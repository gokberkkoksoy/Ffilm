//
//  Network.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 1.08.2021.
//

import Foundation

struct Network {
    
    static var shared = Network()
    var task = URLSessionDataTask()
    var language = Bundle.main.preferredLocalizations.first == "tr" ? NetworkConstants.languageTR : NetworkConstants.languageEN
    
    /// Makes a network call to MovieDB api and returns either a "movie with details (MovieDetail)" or "a list of movies (MovieCategory)". You can parse any kind of data by only changing the URL and parameters.
    /// - Warning: This method is used for 3 different cases. Getting the popular movies(default), searching for a movie, or getting details of a movie. Parameter usage for each case will be different, therefore all parameters have a  default value. Default values have no effect on network calls. They will be modified due to their use cases.
    /// - Parameter id: Default value is 0. You need to use it when getting a detail of a movie. The value will be updated to movie id. Do NOT use it unless you are getting a movie detail.
    /// - Parameter url: Default value is empty string. If you request a list of movies (either the default one or the search results), pass the URL you want to get the movies list from.
    /// - Parameter query: Is used for searching a movie. If you are not searching, default value  will be an empty string and results will be the default movie list (popular movies).
    /// - Parameter page: Is used for pagination. Default value is 0. If you are getting a movie detail, this value will not be modified. When requesting a movie list, it will start from 1 and continue to increase whenever user requests another page of movies.
    /// - Parameter isVideo: Is used for getting video url. Set this to true if you are about to show a video. It will get the URL of the video.
    /// - Parameter completion: If network call succeeds, data will be parsed into given data model  T. If fails, it will return an FFError.
    mutating func getMovies<T: Decodable>(id: Int = .zero, from url: String = "", with query: String = "", in page: Int = .zero, isVideo: Bool = false, completion: @escaping (Result<T, FFError>) -> Void) {
        var url = URL(string: NetworkConstants.basePopularURL)
        if id != .zero  {
            url = URL(string: "\(NetworkConstants.baseMovieURL)\(String(id))\(NetworkConstants.apiKey)\(language)") // for detail
        } else {
            var queryString = ""
            if query != "" { queryString = "&query=\(query)" }
            url = URL(string: "\((queryString == "" ? NetworkConstants.basePopularURL : NetworkConstants.movieSearchURL))\(NetworkConstants.apiKey)\(queryString)\(NetworkConstants.page)\(page)")
        }
        if isVideo {
            url =  URL(string: "\(NetworkConstants.baseMovieURL)\(String(id))/videos\(NetworkConstants.apiKey)")
        }
        if let callURL = url {
            let urlRequest = URLRequest(url: callURL)
            task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
                if let _ = error { completion(.failure(.unableToComplete)) }
                
                if let data = data {
                    do {
                        let result = try JSONDecoder().decode(T.self, from: data)
                        completion(.success(result))
                    } catch {
                        completion(.failure(.invalidData))
                    }
                }
            }
            task.resume()
        }
    }
}
