//
//  Movies.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 1.08.2021.
//

import Foundation

struct MovieCategory: Codable {
    var page: Int?
    var results: [Movie]?
    var totalPages: Int?
    
    enum CodingKeys: String, CodingKey {
        case page
        case results
        case totalPages = "total_pages"
    }
}
