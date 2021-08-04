//
//  Network.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 1.08.2021.
//

import Foundation

struct Network {
    
    static let shared = Network()
    
    func getMovies(from url: String, in page: Int, completion: @escaping (Result<MovieCategory, Error>) -> Void) {
        let callurl = url + NetworkConstants.apiKey + NetworkConstants.language + NetworkConstants.page + String(page)
        print(callurl)
        let urlRequest = URLRequest(url: URL(string: callurl)!)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error { completion(.failure(error)) }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(MovieCategory.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    func getMovieDetail(of movie: Int,completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        let url = NetworkConstants.baseMovieURL + String(movie) + NetworkConstants.apiKey + NetworkConstants.language
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error { completion(.failure(error)) }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(MovieDetail.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
    
    func getMovies(from url: String, with query: String, in page: Int, completion: @escaping (Result<MovieCategory, Error>) -> Void) {
        let url = NetworkConstants.movieSearchURL + NetworkConstants.apiKey + query + NetworkConstants.page + "\(page)"
        let urlRequest = URLRequest(url: URL(string: url)!)
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error { completion(.failure(error)) }
            
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(MovieCategory.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        dataTask.resume()
    }
}
