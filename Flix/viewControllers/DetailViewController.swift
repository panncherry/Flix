//
//  DetailViewController.swift
//  Flix
//
//  Created by Pann Cherry on 9/11/18.
//  Copyright © 2018 Pann Cherry. All rights reserved.
//

import UIKit

enum MovieKeys{
    static let title = "title"
    static let release_date = "release_date"
    static let overview = "overview"
    static let backdropPath = "backdrop_path"
    static let posterPath = "poster_path"
}

class DetailViewController: UIViewController {

    @IBOutlet weak var backDropImageView: UIImageView!
    
    @IBOutlet weak var posterImageView: UIImageView!
    
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let movie = movie {
            titleLable.text = movie[MovieKeys.title] as? String
            releaseDateLabel.text = movie[MovieKeys.release_date] as? String
            overviewLabel.text = movie[MovieKeys.overview] as? String
            
            let backdropPathString = movie[MovieKeys.backdropPath] as? String
            let posterPathString = movie[MovieKeys.posterPath] as? String
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            
            let backdropURL = URL(string: baseURLString + backdropPathString!)!
            backDropImageView.af_setImage(withURL: backdropURL)
            
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
