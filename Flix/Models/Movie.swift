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
    var id: NSNumber
    var genreIds: [Genre] = []
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No overview"
        release_date = dictionary["release_date"] as? String ?? "No release date"
        posterPath = dictionary["poster_path"] as? String ?? "No poster path"
        backdropPath = dictionary["backdrop_path"] as? String ?? "No backdrop path"
        id = dictionary["id"] as! NSNumber

        let genreIds = dictionary["genre_ids"] as? [Int] ?? []
        for id in genreIds {
            self.genreIds.append(Genre(id: id))
        }
    }

    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        return movies.sorted { movie1, movie2 in
            return movie1.release_date > movie2.release_date
        }
    }
}
