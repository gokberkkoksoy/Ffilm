//
//  Network.swift
//  A3
//
//  Created by Gökberk Köksoy on 29.07.2021.
//

import Foundation

struct Network {
    
    static let shared = Network()
    
    func getNames(completion: @escaping (Result<[Team], Error>) -> Void) {
        let urlRequest = URLRequest(url: URL(string: Constants.endpoint)!)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error { completion(.failure(error)) }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Teams.self, from: data)
                    completion(.success(result.teams ?? []))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}
