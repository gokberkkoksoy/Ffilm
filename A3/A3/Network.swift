//
//  Network.swift
//  A3
//
//  Created by Gökberk Köksoy on 29.07.2021.
//

import Foundation

struct Network {
    
    static let shared = Network()
    
    let endpoint = "https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l=English%20Premier%20League"
    
    func getNames(completion: @escaping (Result<[Team], Error>) -> Void) {
        let urlRequest = URLRequest(url: URL(string: endpoint)!)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print(error)
                completion(.failure(error))
            }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(Teams.self, from: data)
                    completion(.success(result.teams!))
                } catch {
                    completion(.failure(error))
                }
            }
            
        }
        dataTask.resume()
    }
}
