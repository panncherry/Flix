//
//  OLDMovieCell.swift
//  Flix
//
//  Created by Pann Cherry on 9/4/18.
//  Copyright © 2018 Pann Cherry. All rights reserved.
//

import UIKit

class OLDMovieCell: UITableViewCell {
    
    // MARK: IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var movie: Movie! {
        willSet(movie){
            self.titleLabel.text = movie.title
            self.overviewLabel.text = movie.overview
            let posterPathString = movie.posterPath
            let smallPosterPath = "https://image.tmdb.org/t/p/w45"
            let largePosterPath = "https://image.tmdb.org/t/p/original"
            imageLoad(smallImgURL: smallPosterPath + posterPathString, largeImgURL: largePosterPath + posterPathString, img: posterImageView)
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    func imageLoad (smallImgURL: String, largeImgURL: String, img:UIImageView) {
        let smallImgReq = URLRequest(url: URL(string: smallImgURL)!)
        let largeImgReq = URLRequest(url: URL(string: largeImgURL)!)
        img.setImageWith(smallImgReq, placeholderImage: #imageLiteral(resourceName: "PlaceHolderImg"), success: { (smallImgReq, smallImgResponse, smallImg) -> Void in
            img.alpha = 0.0
            img.image = smallImg
                            
            UIView.animate(withDuration: 0.3, animations: {()-> Void in img.alpha = 1.0 }, completion: { (success) -> Void in
                img.setImageWith(largeImgReq, placeholderImage: smallImg,success: { (largeImgReq, largeImgResponse, largeImg) in
                    img.image = largeImg }, failure: { (request, response, error) in })
            })
        }) { (request, response, error) -> Void in
            
        }
    }
}
