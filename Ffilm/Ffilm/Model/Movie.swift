//
//  Movie.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 1.08.2021.
//

import Foundation

struct Movie: Codable, Hashable {
    var posterPath: String?
    var title: String?
    var id: Int?
    let uuid = UUID()

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
        case id
    }
    
}
