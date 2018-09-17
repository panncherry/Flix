//
//  PosterDetailViewController.swift
//  Flix
//
//  Created by Pann Cherry on 9/12/18.
//  Copyright © 2018 Pann Cherry. All rights reserved.
//

import UIKit

enum MovieKey{
    static let title = "title"
    static let release_date = "release_date"
    static let overview = "overview"
    static let backdropPath = "backdrop_path"
    static let posterPath = "poster_path"
    
}

class PosterDetailViewController: UIViewController {

    @IBOutlet weak var backdropImageView: UIImageView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
     
    var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            titleLabel.text = movie[MovieKey.title] as? String
            releaseDateLabel.text = movie[MovieKey.release_date] as? String
            overviewLabel.text = movie[MovieKey.overview] as? String
            let backdropPathString = movie[MovieKey.backdropPath] as? String
            let posterPathString = movie[MovieKey.posterPath] as? String
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let backdropURL = URL(string: baseURLString + backdropPathString!)!
            backdropImageView.af_setImage(withURL: backdropURL)
            let posterPathURL = URL(string: baseURLString + posterPathString!)!
            posterImageView.af_setImage(withURL: posterPathURL)
        }
    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trailerViewController = segue.destination as! MovieTrailerViewController
        trailerViewController.movie = movie
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
