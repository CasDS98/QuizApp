//
//  ApiModel.swift
//  QuizApp
//
//  Created by user230710 on 12/31/22.
//

import Foundation
struct Request: Codable {
    let date: String?
    let url: String?
    let data: Data?
}


struct Data: Codable {
    let events, births, deaths: [Event]?

    enum CodingKeys: String, CodingKey {
        case events = "Events"
        case births = "Births"
        case deaths = "Deaths"
    }
}


struct Event: Codable {
    let year, text, html, noYearHTML: String?
    let links: [Link]?

    enum CodingKeys: String, CodingKey {
        case year, text, html
        case noYearHTML = "no_year_html"
        case links
    }
}

struct Link: Codable {
    let title: String?
    let link: String?
}
