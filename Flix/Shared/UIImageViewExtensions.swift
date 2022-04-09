//
//  UIImageViewExtensions.swift
//  Flix
//
//  Created by Pann Cherry on 4/8/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit

extension UIImageView {

    // Load the low resolution image first and then switch to the high resolution image when complete for larger poster
    func loadImage(for movie: Movie) {

        let smallImageURLString = NetworkManager.smallPosterPath + movie.posterPath
        let largeImageURLString = NetworkManager.largePosterPath + movie.posterPath

        let smallImageRequest = URLRequest(url: URL(string: smallImageURLString)!)
        let largeImageRequest = URLRequest(url: URL(string: largeImageURLString)!)

        self.setImageWith(smallImageRequest, placeholderImage: #imageLiteral(resourceName: "PlaceHolderImg"), success: { (smallImageRequest, smallImageResponse, smallImage) -> Void in
            self.alpha = 0.0
            self.image = smallImage

            UIView.animate(withDuration: 0.6, animations: {()-> Void in
                self.alpha = 1.0
            }, completion: { (success) -> Void in
                self.setImageWith(largeImageRequest, placeholderImage: smallImage, success: { (largeImageReqeuest, largeImageResponse, largeImage) in
                    self.image = largeImage
                }, failure: { (request, response, error) in })
            })
        }) { (request, response, error) -> Void in }
    }
}
