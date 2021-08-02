//
//  Movies.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 1.08.2021.
//

import Foundation

struct GlobalMovies: Codable {
    var page: Int?
    var results: [Movie]?
}
