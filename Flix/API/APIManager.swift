//
//  APIManager.swift
//  Flix
//
//  Created by Pann Cherry on 4/9/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit

class APIManager {
    static let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
    static let baseUrl = "https://api.themoviedb.org/3/movie/"
    static let smallPosterPath = "https://image.tmdb.org/t/p/w45"
    static let largePosterPath = "https://image.tmdb.org/t/p/original"
    static let movieTrailerPath = "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"
    static let nowPlayingURL = URL(string: APIManager.baseUrl + "now_playing?api_key=\(APIManager.apiKey)")!
    static let popularMoviesURL = URL(string: APIManager.baseUrl + "popular?api_key=\(APIManager.apiKey)")!
}
