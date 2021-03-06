//
//  MovieDetail.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 4.08.2021.
//

import Foundation

struct MovieDetail: Codable {

    var backdropPath: String?
    var overview: String?
    var releaseDate: String?
    var genres: [Genre]?
    var id: Int?
    var title: String?
    var runtime: Int?
    var voteAverage: Double?
    var voteCount: Int?
    var status: String?
    var tagline: String?
    var posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case overview
        case releaseDate = "release_date"
        case genres
        case id
        case title
        case runtime
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case status
        case tagline
        case posterPath = "poster_path"

    }
    
}
