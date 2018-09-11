//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Pann Cherry on 8/27/18.
//  Copyright © 2018 Pann Cherry. All rights reserved.
//

import UIKit
import AlamofireImage

class NowPlayingViewController: UIViewController, UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var movies: [[String: Any]] = []
    var refreshControl: UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refreshScreen()
    }
    
    //this method refreshes the network and fetch the movies
    func refreshScreen(){
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        tableView.dataSource = self
        tableView.rowHeight = 275
        fetchMovies()
    }
    
    //this method refresh the page and fetch movies
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchMovies()
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
                self.networkErrorAlert(title: "Network Error", message: "Please try again later.")
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String: Any]]
                self.movies = movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }
        }
        task.resume() //starts the task
    }
    
    //this method display error message when network fails
    func networkErrorAlert(title:String, message:String){
        let networkErrorAlert = UIAlertController(title: "Network Error", message: "The internet connection appears to be offline. Please try again later.", preferredStyle: UIAlertControllerStyle.alert)
        networkErrorAlert.addAction(UIAlertAction(title: "Try again", style: UIAlertActionStyle.default, handler: { (action) in self.fetchMovies()}))
        self.present(networkErrorAlert, animated: true, completion: nil)
    }
    
    //this method tells how many cells we are going to have
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    //this method tells what the cell is going to be
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        let posterPathString = movie["poster_path"] as! String
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        let posterURL = URL(string: baseURLString + posterPathString)!
        cell.posterImageView.af_setImage(withURL: posterURL)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let detailViewController = segue.destination as! DetailViewController
            detailViewController.movie = movie
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
