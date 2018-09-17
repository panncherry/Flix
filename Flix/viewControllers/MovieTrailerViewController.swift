//
//  MovieTrailerViewController.swift
//  Flix
//
//  Created by Pann Cherry on 9/16/18.
//  Copyright © 2018 Pann Cherry. All rights reserved.
//

import UIKit
import WebKit

class MovieTrailerViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var movieTrailerWebView: WKWebView!
    var movie: [String: Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let id = movie!["id"] as! NSNumber
        let movieBaseURLString = "https://api.themoviedb.org/3/movie/"
        let movieBaseURLString2 = "/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US"
        let trailerURL = URL(string: movieBaseURLString + id.stringValue + movieBaseURLString2)
            
        let request = URLRequest(url: trailerURL!, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
        if let error = error {
            print(error.localizedDescription)
        } else if let data = data {
            let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
            let trailers = dataDictionary["results"] as! [[String: Any]]
            let trailer = trailers[0]
            let key = trailer["key"] as! String
            if let youtubeTrailerURL = URL(string: "https://www.youtube.com/watch?v=" + key) {
                let trailerRequest = URLRequest(url: youtubeTrailerURL)
                self.movieTrailerWebView.load(trailerRequest)
                    }
                }
            }
            task.resume()
        }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
