//
//  Network.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 1.08.2021.
//

import Foundation

struct Network {
    
    static let shared = Network()
    
    func getNames(from url: String ,in page: Int, completion: @escaping (Result<GlobalMovies, Error>) -> Void) {
        
        let urlRequest = URLRequest(url: URL(string: url + String(page))!)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error { completion(.failure(error)) }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(GlobalMovies.self, from: data)
                    print(result)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}
