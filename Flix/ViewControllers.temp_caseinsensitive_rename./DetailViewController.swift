//
//  DetailViewController.swift
//  Flix
//
//  Created by Pann Cherry on 9/11/18.
//  Copyright © 2018 Pann Cherry. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: IBOutlets
    @IBOutlet weak var backDropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    
    // MARK: Properties
    var movie: Movie?
    
    
    // MARK: Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movie = movie {
            titleLable.text = movie.title
            releaseDateLabel.text = movie.release_date
            overviewLabel.text = movie.overview
            
            let backdropPathString = movie.backdropPath
            let posterPathString = movie.posterPath
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            
            let backdropURL = URL(string: baseURLString + backdropPathString)!
            backDropImageView.af_setImage(withURL: backdropURL)
            
            let posterPathURL = URL(string: baseURLString + posterPathString)!
            posterImageView.af_setImage(withURL: posterPathURL)
        }
    }
    
    
    // MARK: Segue to movie trailer
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let trailerViewController = segue.destination as! MovieTrailerViewController
        trailerViewController.movie = movie
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
