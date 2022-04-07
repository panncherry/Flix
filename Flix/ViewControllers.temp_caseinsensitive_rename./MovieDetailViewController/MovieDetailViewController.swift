//
//  MovieDetailViewController.swift
//  Flix
//
//  Created by Pann Cherry on 4/6/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit

class MovieDetailViewController: CommonViewController {

    // IBOutlets
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var backdropImageView: UIImageView!

    // Properties
    var movie: Movie {
        didSet{
            self.configure()
        }
    }

    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.configure()
        self.navigationItem.title = "Overview"
        self.leftNavigationBarCustomBackButton()
    }

    private func configure() {
        movieTitleLabel.text = movie.title
        releaseDateLabel.text = movie.release_date
        overviewLabel.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.\n\nDuis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam"//movie.overview

        let backdropPathString = movie.backdropPath
        let posterPathString = movie.posterPath
        let baseURLString = "https://image.tmdb.org/t/p/w500"

        let backdropURL = URL(string: baseURLString + backdropPathString)!
        backdropImageView.af_setImage(withURL: backdropURL)

        let posterPathURL = URL(string: baseURLString + posterPathString)!
        posterImageView.af_setImage(withURL: posterPathURL)
    }
}
