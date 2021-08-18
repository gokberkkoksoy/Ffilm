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
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."

    var localized: String {
        switch self {
        case .unableToFavorite:
            return NSLocalizedString("UnableToFavorite", comment: "")
        case .alreadyInFavorites:
            return NSLocalizedString("AlreadyInFavorites", comment: "")
        case .unableToComplete:
            return NSLocalizedString("UnableToComplete", comment: "")
        case  .invalidResponse:
            return NSLocalizedString("InvalidResponse", comment: "")
        case .invalidData:
            return NSLocalizedString("InvalidData", comment: "")
        }
    }
}
