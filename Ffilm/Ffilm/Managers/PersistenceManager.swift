//
//  PersistenceManager.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 6.08.2021.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites =  "favorites"
    }

    static func updateWith(movieID: Int, actionType: PersistenceActionType, completed: @escaping (FFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(var movieIDs):
                switch actionType {
                case .add:
                    if movieIDs.contains(movieID){
                        completed(.alreadyInFavorites)
                    } else {
                        movieIDs.insert(movieID, at: .zero)
                    }
                case .remove:
                    movieIDs.removeAll { $0 == movieID }
                }
                completed(saveFavorites(favorites: movieIDs))
            case.failure(_):
                completed(.unableToFavorite)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping(Result<[Int], FFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? [Int] else {
            completed(.success([]))
            return
        }
        completed(.success(favoritesData))
    }
    
    static func saveFavorites(favorites: [Int]) -> FFError? {
        defaults.set(favorites, forKey: Keys.favorites)
        return nil
    }
    
}
