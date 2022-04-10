//
//  MoviePosterCollectionViewCell.swift
//  Flix
//
//  Created by Pann Cherry on 4/7/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit

class MoviePosterCollectionViewCell: UICollectionViewCell {

    static var nibName = "MoviePosterCollectionViewCell"
    static var identifier = "MoviePosterCollectionViewCell"

    @IBOutlet weak var posterImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.posterImageView.image = nil
    }

}
