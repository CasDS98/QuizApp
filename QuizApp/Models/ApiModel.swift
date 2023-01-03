//
//  ApiModel.swift
//  QuizApp
//
//  Created by user230710 on 12/31/22.
//

import Foundation
//used this site to generate models: https://app.quicktype.io/ 
//Event data models
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


//image url models
struct WikiData: Codable {
    let batchcomplete: Bool?
    let query: Query?
}

struct Query: Codable {
    let pages: [Page]?
}

struct Page: Codable {
    let pageid, ns: Int?
    let title: String?
    let thumbnail: Thumbnail?
    let pageimage: String?
    let terms: Terms?
}

struct Terms: Codable {
    let alias, label, termsDescription: [String]?

    enum CodingKeys: String, CodingKey {
        case alias, label
        case termsDescription = "description"
    }
}

struct Thumbnail: Codable {
    let source: String?
    let width, height: Int?
}

