//
//  QueryOption.swift
//  QuizApp
//
//  Created by user230710 on 12/30/22.
//

import Foundation

struct QueryOption{
    let title : String
    let description : String
    let year : Int
    let showYear = false
    
    init(title: String, description: String, year: Int) {
        self.title = title
        self.description = description
        self.year = year
    }
}
