//
//  Constants.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 2.08.2021.
//

import Foundation

struct NetworkConstants {
    static let basePopularURL = "https://api.themoviedb.org/3/movie/popular"
    static let upcomingURL = "https://api.themoviedb.org/3/movie/upcoming"
    static let topRatedURL = "https://api.themoviedb.org/3/movie/top_rated"
    static let apiKey = "?api_key=e5ca8cf8b860272cdc4691ae12d306cf"
    static let languageEN = "&language=en-US"
    static let languageTR  = "&language=tr"
    static let page = "&page="
    static let baseImageURL = "https://image.tmdb.org/t/p/w500/"
    static let backdropURL = "https://image.tmdb.org/t/p/original"
    static let baseMovieURL = "https://api.themoviedb.org/3/movie/"
    static let movieSearchURL = "https://api.themoviedb.org/3/search/movie/"
}
