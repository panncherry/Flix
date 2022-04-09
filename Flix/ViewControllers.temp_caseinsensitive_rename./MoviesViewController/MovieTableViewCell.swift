//
//  MovieTableViewCell.swift
//  Flix
//
//  Created by Pann Cherry on 4/6/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    static let nibName = "MovieTableViewCell"
    static let identifier = "MovieTableViewCell"
    
    var movie: Movie! {
        willSet(movie){
            self.titleLabel.text = movie.title
            self.overviewLabel.text = movie.overview
            self.posterImageView.loadImage(for: movie)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.overviewLabel.text = nil
        self.posterImageView.image = nil
    }
    
    func configure(movie: Movie) {
        self.movie = movie
    }
}
