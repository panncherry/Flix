//
//  Movie.swift
//  Flix
//
//  Created by Pann Cherry on 10/4/18.
//  Copyright © 2018 Pann Cherry. All rights reserved.
//

import Foundation

class Movie {
    var title: String
    var release_date: String
    var overview: String
    var posterPath: String
    var backdropPath: String
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No overview"
        release_date = dictionary["release_date"] as? String ?? "No release date"
        posterPath = dictionary["poster_path"] as? String ?? "No poster path"
        backdropPath = dictionary["backdrop_path"] as? String ?? "No backdroppath"
    }
    
}
