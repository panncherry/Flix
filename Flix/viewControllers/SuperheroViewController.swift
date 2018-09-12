//
//  SuperheroViewController.swift
//  Flix
//
//  Created by Pann Cherry on 9/11/18.
//  Copyright © 2018 Pann Cherry. All rights reserved.
//

import UIKit

class SuperheroViewController: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        let cellPerLine: CGFloat = 2
        let interItemSpacingTotal = layout.minimumLineSpacing * (cellPerLine - 1)
        let width = collectionView.frame.size.width/cellPerLine - interItemSpacingTotal/cellPerLine
        layout.itemSize = CGSize(width: width, height: width*3/2)
        fetchMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.item]
        if let posterPathString = movie["poster_path"] as? String {
            let baseURLString = "https://image.tmdb.org/t/p/w500"
            let posterURL = URL(string: baseURLString + posterPathString)!
            cell.posterImageView.af_setImage(withURL: posterURL)
        }
        return cell
    }
    
    //this method fetches now playing movies
    func fetchMovies () {
        
        //create URL
        let createURL = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=41219c2c63e30faae11b6519a4be8da0")!
        
        //create URL request
        let requestURL = URLRequest(url: createURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        
        //create URL session
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        //create a task to get the data
        let task = session.dataTask(with: requestURL){
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                //self.networkErrorAlert(title: "Network Error", message: "Please try again later.")
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                self.collectionView.reloadData()
                //self.refreshControl.endRefreshing()
            }
        }
        task.resume() //starts the task
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
