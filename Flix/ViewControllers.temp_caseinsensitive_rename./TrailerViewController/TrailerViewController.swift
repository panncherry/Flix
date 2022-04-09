//
//  TrailerViewController.swift
//  Flix
//
//  Created by Pann Cherry on 4/7/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController, WKUIDelegate {

    var movie: Movie
    @IBOutlet weak var webView: WKWebView!

    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.playVideo()
        self.navigationItem.title = "Movie Trailer"
    }

    private func playVideo() {
        let trailerURL = URL(string: NetworkManager.baseUrl + movie.id.stringValue + NetworkManager.movieTrailerPath)
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
                    self.webView.load(trailerRequest)

                    let stringurl = "https://www.youtube.com/watch?v=" + key
                    if let encodedURL = stringurl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
                       let url = URL(string: encodedURL) {
                        self.webView.load(URLRequest(url: url))
                    }
                }
            }
        }

        task.resume()
    }

}
