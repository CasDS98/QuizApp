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
                    if(diff < 0) {correctAnswer()}
                    else {wrongAnswer()}
                        
                case .after:
                    if(diff > 0) {correctAnswer()}
                    else {wrongAnswer()}
            }
        }
    }
    
    mutating private func correctAnswer()
    {
        score += 1
        switchQueryOptions()
    }
    
    mutating private func wrongAnswer()
    {
        isPlaying = false
    }
    
    mutating func reset()
    {
        score = 0;
        isPlaying = true
    }
    
    mutating private func switchQueryOptions()
    {
        //transfer data from query b to query a
        queryOptionA.title = queryOptionB.title
        queryOptionA.description = queryOptionB.description
        queryOptionA.year = queryOptionB.year
        
        //TODO get new data from api
        queryOptionB.year = Int.random(in: -2000..<2000)
        
        
    }
    
    private func getRandomEvent()
    {
        let url = URL(string: "https://history.muffinlabs.com/date/2/14")!
        URLSession.shared.fetchData(for: url) { (result: Result<Request, Error>) in
            switch result {
            case .success(_):
              print("success")
            case .failure(_):
                print("failure")
          }
        }
    }
}

//code from https://lukeroberts.co/blog/fetch-data-api/
extension URLSession {
  func fetchData<T: Decodable>(for url: URL, completion: @escaping (Result<T, Error>) -> Void) {
    self.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(.failure(error))
      }

      if let data = data {
        do {
          let object = try JSONDecoder().decode(T.self, from: data)
          completion(.success(object))
        } catch let decoderError {
          completion(.failure(decoderError))
        }
      }
    }.resume()
  }
}
