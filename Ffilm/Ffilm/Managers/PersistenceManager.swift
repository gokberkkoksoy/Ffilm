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
    
    static func updateWith(movie: Movie, actionType: PersistenceActionType, completed: @escaping (FFError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let movies):
                var retrievedMovies = movies
                
                switch actionType {
                case .add:
                    guard !retrievedMovies.contains(movie) else {
                        completed(.alreadyInFavorites)
                        return
                    }
                    retrievedMovies.append(movie)
                case .remove:
                    retrievedMovies.removeAll { $0.id == movie.id }
                }
                
                completed(saveFavorites(favorites: retrievedMovies))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    static func retrieveFavorites(completed: @escaping (Result<[Movie], FFError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do {
            let movies = try JSONDecoder().decode([Movie].self, from: favoritesData)
            completed(.success(movies))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
    static func saveFavorites(favorites: [Movie]) -> FFError? {
        
        do {
            let encodedFavorites = try JSONEncoder().encode(favorites)
            defaults.setValue(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
}
