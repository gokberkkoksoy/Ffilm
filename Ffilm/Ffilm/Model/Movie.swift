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
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case title
        case id
    }
    
}

struct MovieDetail: Codable {

    var backdropPath: String?
    var overview: String?
    var releaseDate: String?
    var id: Int?
    var title: String?
    var runtime: Int?
    var voteAverage: Double?
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case overview
        case title
        case id
        case runtime
        case voteAverage = "vote_average"
        
    }
    
}


