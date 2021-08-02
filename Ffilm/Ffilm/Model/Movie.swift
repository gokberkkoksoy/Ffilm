//
//  Movie.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 1.08.2021.
//

import Foundation

struct Movie: Codable, Hashable {
    var posterPath: String?
    var overview: String?
    var releaseDate: String?
    var id: Int?
    var originalTitle: String?
    var title: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case originalTitle = "original_title"
        case overview
        case title
        case id
    }
    
}


