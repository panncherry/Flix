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
