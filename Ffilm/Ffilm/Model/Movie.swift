//
//  Movie.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 1.08.2021.
//

import Foundation

struct Movie: Codable, Hashable {
    var poster_path: String?
    var overview: String?
    var release_date: String?
    var id: Int?
    var original_title: String?
    var original_language: String?
    var title: String?
}
