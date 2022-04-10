//
//  DataProvider.swift
//  Flix
//
//  Created by Pann Cherry on 4/10/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import Foundation

class DataProvider {

    static var sharedDataProvider = DataProvider()

    // Returns genre data of selected segmented control for popular movies.
    // Needs to update values if segment values are to changed in future
    func selectedPopularMovieTabData(_ selectedSegmentIndex: Int) -> SelectedPopularMovieGenreData {

        guard selectedSegmentIndex >= 0 && selectedSegmentIndex < 20 else {
            return SelectedPopularMovieGenreData(type: .romance, text: "movies")
        }

        if selectedSegmentIndex == 0 {
            return SelectedPopularMovieGenreData(type: .all, text: "movies")
        }

        if selectedSegmentIndex == 1 {
            return SelectedPopularMovieGenreData(type: .adventure, text: "adventure movies")
        }

        if selectedSegmentIndex == 2 {
            return SelectedPopularMovieGenreData(type: .animation, text: "animation movies")
        }

        if selectedSegmentIndex == 3 {
            return SelectedPopularMovieGenreData(type: .action, text: "action movies")
        }

        if selectedSegmentIndex == 4 {
            return SelectedPopularMovieGenreData(type: .comedy, text: "comedy movies")
        }

        if selectedSegmentIndex == 5 {
            return SelectedPopularMovieGenreData(type: .crime, text: "crime movies")
        }

        if selectedSegmentIndex == 6 {
            return SelectedPopularMovieGenreData(type: .documentary, text: "documentary movies")
        }

        if selectedSegmentIndex == 7 {
            return SelectedPopularMovieGenreData(type: .drama, text: "drama movies")
        }

        if selectedSegmentIndex == 8 {
            return SelectedPopularMovieGenreData(type: .family, text: "family movies")
        }

        if selectedSegmentIndex == 9 {
            return SelectedPopularMovieGenreData(type: .fantasy, text: "fantasy movies")
        }

        if selectedSegmentIndex == 10 {
            return SelectedPopularMovieGenreData(type: .history, text: "history movies")
        }

        if selectedSegmentIndex == 11 {
            return SelectedPopularMovieGenreData(type: .horror, text: "horror movies")
        }

        if selectedSegmentIndex == 12 {
            return SelectedPopularMovieGenreData(type: .music, text: "musical movies")
        }

        if selectedSegmentIndex == 13 {
            return SelectedPopularMovieGenreData(type: .mystery, text: "mystery movies")
        }

        if selectedSegmentIndex == 14 {
            return SelectedPopularMovieGenreData(type: .romance, text: "romance movies")
        }

        if selectedSegmentIndex == 15 {
            return SelectedPopularMovieGenreData(type: .scienceFiction, text: "science fiction movies")
        }

        if selectedSegmentIndex == 16 {
            return SelectedPopularMovieGenreData(type: .tvMovie, text: "TV movies")
        }

        if selectedSegmentIndex == 17 {
            return SelectedPopularMovieGenreData(type: .thriller, text: "thriller movies")
        }

        if selectedSegmentIndex == 18 {
            return SelectedPopularMovieGenreData(type: .war, text: "war movies")
        }

        if selectedSegmentIndex == 19 {
            return SelectedPopularMovieGenreData(type: .western, text: "western movies")
        }

        return SelectedPopularMovieGenreData(type: .all, text: "movies")
    }
    
}
