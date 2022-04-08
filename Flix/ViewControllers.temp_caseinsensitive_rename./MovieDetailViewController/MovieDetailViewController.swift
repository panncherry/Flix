//
//  MovieDetailViewController.swift
//  Flix
//
//  Created by Pann Cherry on 4/6/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class MovieDetailViewController: CommonViewController {

    // IBOutlets
    @IBOutlet weak var playButton: UIButton!
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

    @IBAction func playButtonHit(_ sender: Any) {
        let viewController = TrailerViewController(movie: self.movie)
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    private func configure() {
        movieTitleLabel.text = movie.title
        releaseDateLabel.text = movie.release_date
        overviewLabel.text = movie.overview

        let backdropPathString = movie.backdropPath
        let posterPathString = movie.posterPath
        let baseURLString = "https://image.tmdb.org/t/p/w500"

        let backdropURL = URL(string: baseURLString + backdropPathString)!
        backdropImageView.setImageWith(backdropURL)

        let posterPathURL = URL(string: baseURLString + posterPathString)!
        posterImageView.setImageWith(posterPathURL)
    }
}
