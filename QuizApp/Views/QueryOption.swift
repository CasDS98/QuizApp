//
//  QueryOption.swift
//  QuizApp
//
//  Created by user230710 on 12/30/22.
//

import Foundation

struct QueryOption{
    var title : String
    var description : String
    var year : Int
    var showYear = false
    
    init(title: String, description: String, year: Int) {
        self.title = title
        self.description = description
        self.year = year
    }
}
