//
//  SelectedPopularMoiveGenreData.swift
//  Flix
//
//  Created by Pann Cherry on 4/10/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

struct SelectedPopularMovieGenreData {
    var type: GenreType
    var text: String

    init(type: GenreType, text: String) {
        self.type = type
        self.text = text
    }
}
