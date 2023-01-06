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
    private(set) var highScore : Int = 0


    init() {
        self.queryOptionA = QueryOption(title: "titleA", description: "descriptionA", year: 2000)
        self.queryOptionB = QueryOption(title: "titleB", description: "descriptionB", year: 1000)
        queryOptionB.HideYear()
        highScore = GetHighScore()
    }
    
    private func GetHighScore() -> Int{
        let defaults = UserDefaults.standard
        return defaults.value(forKey: "highScore") as? Int ?? 0
    }
    
    private mutating func SetNewHighScore(newHighScore : Int)
    {
        if(newHighScore > GetHighScore())
        {
            let defaults = UserDefaults.standard
            defaults.set(newHighScore, forKey: "highScore")
            highScore = newHighScore
        }
    }
    
    mutating func registerAnswer(answer : Answer)
    {
        let diff = queryOptionA.year - queryOptionB.year
        
        if(diff == 0)
        {
             correctAnswer()
        }
        else
        {
            switch answer{
                case .before:
                    if(diff < 0) { correctAnswer()}
                    else { wrongAnswer()}
                        
                case .after:
                    if(diff > 0) { correctAnswer()}
                    else { wrongAnswer()}
            }
        }
        SetNewHighScore(newHighScore: score)
    }
    
    mutating private func correctAnswer()
    {
        score += 1
        switchQueryOptions()
        queryOptionB.HideYear()
    }
    
    mutating private func wrongAnswer()
    {
        isPlaying = false
        queryOptionB.ShowYear()
    }
    
    mutating func reset()
    {
        score = 0;
        isPlaying = true

        queryOptionA = getRandomQueryOption()
        queryOptionB = getRandomQueryOption()

        
        
         queryOptionA.imageUrl =  getImageUrl(searchTerm: queryOptionA.title)
         queryOptionB.imageUrl =  getImageUrl(searchTerm: queryOptionB.title)
    
        
        queryOptionA.isUpper = true
        queryOptionB.HideYear()
    }
    
    mutating private func switchQueryOptions()
    {
        //transfer data from query b to query a
        queryOptionA.title = queryOptionB.title
        queryOptionA.description = queryOptionB.description
        queryOptionA.year = queryOptionB.year
        queryOptionA.imageUrl = queryOptionB.imageUrl
        
        //get new data from api
        queryOptionB = getRandomQueryOption()
      
        //get image url
        queryOptionB.imageUrl =  getImageUrl(searchTerm: queryOptionB.title)
    }
    


    
    private func getRandomQueryOption() -> QueryOption
    {
        let semaphore = DispatchSemaphore(value: 0)
        let fetcher = DataFetcher()
        var queryOption = QueryOption(title: "titleA", description: "descriptionA", year: 2000)
        
        fetcher.fetchEventsWithAsyncURLSession(){result in
            switch result{
            case .success(let request):
                let numberOfEvents = request.data?.events?.count ?? -1
                let randNumber = Int.random(in: 0..<numberOfEvents)
                let event = (request.data?.events?[randNumber])!
                
                //replace years in title and description
                let regex = try! NSRegularExpression(pattern: "\\d{4}")
                let titleString = event.links?[0].title ?? ""
                queryOption.title = regex.stringByReplacingMatches(in: titleString, range: NSRange(location: 0, length: titleString.count), withTemplate:"****")
                let textString = event.text ?? ""
                queryOption.description = regex.stringByReplacingMatches(in: textString, range: NSRange(location: 0, length: textString.count), withTemplate: "****")
                queryOption.year = Int(event.year ?? "0") ?? 0
            case .failure(let error):
                print("Error: \(error)")
                queryOption = QueryOption(title: "titleA", description: "descriptionA", year: 2000)
            }
            semaphore.signal()
        }
        semaphore.wait()
        return queryOption
    }
      /*  Task {
            
            do {
                var queryOption = QueryOption(title: "titleA", description: "descriptionA", year: 2000)
                let request = try await DataFetcher.fetchEventsWithAsyncURLSession()
                let numberOfEvents = request.data?.events?.count ?? -1
                let randNumber = Int.random(in: 0..<numberOfEvents)
                let event = (request.data?.events?[randNumber])!
                
                //replace years in title and description
                let regex = try! NSRegularExpression(pattern: "\\d{4}")
                let titleString = event.links?[0].title ?? ""
                queryOption.title = regex.stringByReplacingMatches(in: titleString, range: NSRange(location: 0, length: titleString.count), withTemplate:"****")
                let textString = event.text ?? ""
                queryOption.description = regex.stringByReplacingMatches(in: textString, range: NSRange(location: 0, length: textString.count), withTemplate: "****")
                queryOption.year = Int(event.year ?? "0") ?? 0
                
                
                return queryOption
            } catch {
                throw error
            }
            
        }
    }*/
    
    private func getImageUrl(searchTerm : String) -> String
    {
        let semaphore = DispatchSemaphore(value: 0)
        let fetcher = DataFetcher()
        var url = ""
        
        fetcher.fetchWikiDatasWithAsyncURLSession(searchTerm: searchTerm){result in
            switch result{
            case .success(let wikiData):
                url = wikiData.query?.pages?[0].thumbnail?.source ?? ""
            case .failure(let error):
                print("Error: \(error)")
                url = ""
            }
            semaphore.signal()
        }
        semaphore.wait()
        return url
    }

}

struct DataFetcher {
    
    enum DataFetcherError: Error {
        case invalidURL
        case missingData
    }
    
    func fetchEventsWithAsyncURLSession(completion: @escaping (Result<Request, Error>) -> Void)  {
        let randMonth = Int.random(in: 1..<13)
        let randDay = Int.random(in: 1..<29)
        guard let url = URL(string: "https://history.muffinlabs.com/date/" + String(randMonth) + "/" + String(randDay)) else {
            completion(.failure(DataFetcherError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            guard let data = data else{
                completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                return
            }
            
            
            do{
                // Parse the JSON data
                let request = try JSONDecoder().decode(Request.self, from: data)
                completion(.success(request))
            }catch{
                completion(.failure(error))
            }
        }.resume()
    }
    
    func fetchWikiDatasWithAsyncURLSession(searchTerm : String, completion: @escaping (Result<WikiData, Error>) -> Void) {

        guard let url = URL(string: "https://en.wikipedia.org/w/api.php?action=query&formatversion=2&format=json&prop=pageimages%7Cpageterms&titles=" + searchTerm.replacingOccurrences(of: " ", with: "%20")) else {
            completion(.failure(DataFetcherError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url){data, response, error in
            if let error = error{
                completion(.failure(error))
                return
            }
            guard let data = data else{
                completion(.failure(NSError(domain: "", code: 0, userInfo: nil)))
                return
            }
            
            
            do{
                // Parse the JSON data
                let wikiData = try JSONDecoder().decode(WikiData.self, from: data)
                completion(.success(wikiData))
            }catch{
                completion(.failure(error))
            }
        }.resume()
    }
}

