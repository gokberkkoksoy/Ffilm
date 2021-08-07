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
            case .success(let movieIDs):
                var retrievedIds = movieIDs
                switch actionType {
                case .add:
                    if retrievedIds.contains(movieID){
                        completed(.alreadyInFavorites)
                    } else {
                        retrievedIds.append(movieID)
                    }
                case .remove:
                    retrievedIds.removeAll { $0 == movieID }
                }
                completed(saveFavorites(favorites: retrievedIds))
            case.failure(let error):
                completed(error)
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
