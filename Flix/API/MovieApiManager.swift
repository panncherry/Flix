//
//  NetworkManager.swift
//  Flix
//
//  Created by Pann Cherry on 10/9/18.
//  Copyright © 2018 Pann Cherry. All rights reserved.
//

import Foundation

struct NetworkResponse{
    var movies: [Movie]?
    var error: Error?
}

class NetworkManager {

    var session: URLSession
    static var sharedNetworkManager = NetworkManager()

    static let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    static let baseUrl = "https://api.themoviedb.org/3/movie/"

    static let smallPosterPath = "https://image.tmdb.org/t/p/w45"
    static let largePosterPath = "https://image.tmdb.org/t/p/original"
    static let movieTrailerPath = "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"

    static let nowPlayingURL = URL(string: NetworkManager.baseUrl + "now_playing?api_key=\(NetworkManager.apiKey)")!
    static let popularMoviesURL = URL(string: NetworkManager.baseUrl + "popular?api_key=\(NetworkManager.apiKey)")!

    init() {
        session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
    }

    func requestMovies(moviesURL: URL, completion: @escaping(NetworkResponse) -> ()) {
        let request = URLRequest(url: moviesURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let task = session.dataTask(with: request) { (data, response, error) in

            if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movieDictionaries = dataDictionary["results"] as! [[String: Any]]
                let movies = Movie.movies(dictionaries: movieDictionaries)
                completion(NetworkResponse(movies: movies, error: nil))
            } else {
                completion(NetworkResponse(movies: nil, error: error))
            }
        }
        task.resume()
    }
}
