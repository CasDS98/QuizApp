//
//  QuizGame.swift
//  QuizApp
//
//  Created by user230710 on 12/30/22.
//

import Foundation

enum Answer{
    case before
    case after
}

struct QuizGame{
    private(set) var queryOptionA: QueryOption
    private(set) var queryOptionB: QueryOption
    private(set) var score : Int = 0
    private(set) var isPlaying : Bool = true


    init() {
        self.queryOptionA = QueryOption(title: "titleA", description: "descriptionA", year: 2000)
        self.queryOptionB = QueryOption(title: "titleB", description: "descriptionB", year: 1000)
    }
    
    mutating func registerAnswer(answer : Answer) async
    {
        let diff = queryOptionA.year - queryOptionB.year
        
        if(diff == 0)
        {
            await correctAnswer()
        }
        else
        {
            switch answer{
                case .before:
                    if(diff < 0) {await correctAnswer()}
                    else {await wrongAnswer()}
                        
                case .after:
                    if(diff > 0) {await correctAnswer()}
                    else {await wrongAnswer()}
            }
        }
    }
    
    mutating private func correctAnswer() async
    {
        score += 1
        await switchQueryOptions()
    }
    
    mutating private func wrongAnswer() async
    {
        isPlaying = false
    }
    
    mutating func reset() async
    {
        score = 0;
        isPlaying = true
        do{
            
            queryOptionA = try await getRandomQueryOption().result.get()
            queryOptionB = try await getRandomQueryOption().result.get()
            
         } catch{
             print("Request failed with error: \(error)")
         }
        
        do{
            try  queryOptionA.imageUrl = await getImageUrl(searchTerm: queryOptionA.title).result.get()
            try  queryOptionB.imageUrl = await getImageUrl(searchTerm: queryOptionB.title).result.get()
         } catch{
             print("Request failed with error: \(error)")
         }
    }
    
    mutating private func switchQueryOptions() async
    {
        //transfer data from query b to query a
        queryOptionA.title = queryOptionB.title
        queryOptionA.description = queryOptionB.description
        queryOptionA.year = queryOptionB.year
        queryOptionA.imageUrl = queryOptionB.imageUrl
        
        //get new data from api
       do{
           try  queryOptionB = await getRandomQueryOption().result.get()
           
        } catch{
            print("Request failed with error: \(error)")
        }
        
        //get image url
        do{
            try  queryOptionB.imageUrl = await getImageUrl(searchTerm: queryOptionB.title).result.get()
         } catch{
             print("Request failed with error: \(error)")
         }
    }
    


    
    private func getRandomQueryOption() async throws -> Task<QueryOption, Error>
    {
        Task {
            
            do {
                var queryOption = QueryOption(title: "titleA", description: "descriptionA", year: 2000)
                let request = try await DataFetcher.fetchEventsWithAsyncURLSession()
                let numberOfEvents = request.data?.events?.count ?? -1
                let randNumber = Int.random(in: 0..<numberOfEvents)
                let event = (request.data?.events?[randNumber])!
                queryOption.title = event.links?[0].title ?? ""
                queryOption.description = event.text ?? ""
                queryOption.year = Int(event.year ?? "0") ?? 0
                return queryOption
            } catch {
                throw error
            }
            
        }
    }
    
    private func getImageUrl(searchTerm : String) async throws -> Task<String, Error>
    {
        Task {
            
            do {
                let wikiData = try await DataFetcher.fetchWikiDatasWithAsyncURLSession(searchTerm: searchTerm)
                return wikiData.query?.pages?[0].thumbnail?.source ?? ""
            } catch {
                throw error
            }
            
        }
    }
    
}

//code from https://swiftsenpai.com/swift/async-await-network-requests/
struct DataFetcher {
    
    enum DataFetcherError: Error {
        case invalidURL
        case missingData
    }
    
    static func fetchEventsWithAsyncURLSession() async throws -> Request {

        guard let url = URL(string: "https://history.muffinlabs.com/date/2/14") else {
            throw DataFetcherError.invalidURL
        }

        // Use the async variant of URLSession to fetch data
        // Code might suspend here
        let (data, _) = try await URLSession.shared.data(from: url)

        // Parse the JSON data
        let request = try JSONDecoder().decode(Request.self, from: data)
        return request
    }
    
    static func fetchWikiDatasWithAsyncURLSession(searchTerm : String) async throws -> WikiData {

        guard let url = URL(string: "https://en.wikipedia.org/w/api.php?action=query&formatversion=2&format=json&prop=pageimages%7Cpageterms&titles=" + searchTerm.replacingOccurrences(of: " ", with: "%20")) else {
            throw DataFetcherError.invalidURL
        }

        // Use the async variant of URLSession to fetch data
        // Code might suspend here
        let (data, _) = try await URLSession.shared.data(from: url)

        // Parse the JSON data
        let wikiData = try JSONDecoder().decode(WikiData.self, from: data)
        return wikiData
    }
}


