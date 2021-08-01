//
//  Network.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 1.08.2021.
//

import Foundation

struct Network {
    
    static let shared = Network()
    
    func getNames(completion: @escaping (Result<[Movie], Error>) -> Void) {
        let urlRequest = URLRequest(url: URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=e5ca8cf8b860272cdc4691ae12d306cf&language=en-US&page=1")!)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error { completion(.failure(error)) }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(GlobalMovies.self, from: data)
                    print(result)
                    completion(.success(result.results ?? []))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}
