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
    var imageUrl : String = ""
    var isYearVisible : Bool = true
    var isUpper : Bool = false
    
    init(title: String, description: String, year: Int) {
        self.title = title
        self.description = description
        self.year = year
    }
    
    mutating func ShowYear()
    {
        isYearVisible = true
    }
    
    mutating func HideYear()
    {
        isYearVisible = false
    }
}
