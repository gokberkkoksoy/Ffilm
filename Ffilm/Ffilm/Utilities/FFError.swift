//
//  FFError.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 6.08.2021.
//

import Foundation

enum FFError: String, Error {
    case unableToFavorite = "There was an error favoriting this movie. Please try again."
    case alreadyInFavorites = "You've already favorited this movie. You must really like it."
}
