//
//  NowPlayingViewController.swift
//  Flix
//
//  Created by Pann Cherry on 8/27/18.
//  Copyright © 2018 Pann Cherry. All rights reserved.
//

import UIKit
import AlamofireImage
import AFNetworking

var allMovies: [[String: Any]] = []

class NowPlayingViewController: UIViewController, UITableViewDataSource, UISearchBarDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var refreshControl: UIRefreshControl!
    
    var movies: [[String: Any]] = []
    
    var filteredMovie:[[String: Any]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        //tableView.rowHeight = 275
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        searchBar.delegate = self
        //searchBar.becomeFirstResponder()
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        self.activityIndicator.startAnimating()
        //code to display the activityIndicator for desired seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.fetchMovies()
        }
        
    }

    //code to fetch now playing movies
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
                self.filteredMovie = self.movies
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
            }
        }
        //starts the task
        task.resume()
    }

    //code to count movies
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    //code to create cell and display data
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        // code to change color of the cell user selected
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.orange
        cell.selectedBackgroundView = backgroundView
        //code to set the color of all cells
        cell.contentView.backgroundColor = UIColor.white
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        let posterPathString = movie["poster_path"] as! String
        /*
        let baseURLString = "https://image.tmdb.org/t/p/w500"
        let posterURL = URL(string: baseURLString + posterPathString)!
        //code to display placeholderImage while fetching poster image
        let placeholderImage = UIImage(named: "PlaceHolderImg")
        //code to display round corner image for selected cell
        let filter = AspectScaledToFillSizeWithRoundedCornersFilter(size: cell.posterImageView.frame.size,radius: 20.0)
        cell.posterImageView.af_setImage(withURL: posterURL, placeholderImage: placeholderImage, filter: filter, imageTransition: .crossDissolve(0.2))
        */

        let smallPosterPath = "https://image.tmdb.org/t/p/w45"
        let largePosterPath = "https://image.tmdb.org/t/p/original"
        imageLoad(smallImgURL: smallPosterPath + posterPathString, largeImgURL: largePosterPath + posterPathString, img: cell.posterImageView)
       
        return cell
    }

    //code to fetch movies when pull to refresh
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchMovies()
    }
    
  // code to update filteredMovie based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movies = searchText.isEmpty ? filteredMovie : filteredMovie.filter { ($0["title"] as! String).lowercased().contains(searchBar.text!.lowercased()) }
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
        fetchMovies()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        allMovies = movies
    }
    
    //code to display error message when network fails
    func networkErrorAlert(title:String, message:String){
        let networkErrorAlert = UIAlertController(title: "Network Error", message: "The internet connection appears to be offline. Please try again later.", preferredStyle: UIAlertController.Style.alert)
        networkErrorAlert.addAction(UIAlertAction(title: "Try again", style: UIAlertAction.Style.default, handler: { (action) in self.fetchMovies()}))
        self.present(networkErrorAlert, animated: true, completion: nil)
    }
    
    //code to load the low resolution image first and then switch to the high resolution image when complete for larger poster
    func imageLoad (smallImgURL: String, largeImgURL: String, img:UIImageView) {
        let smallImgReq = URLRequest(url: URL(string: smallImgURL)!)
        let largeImgReq = URLRequest(url: URL(string: largeImgURL)!)
        img.setImageWith(smallImgReq, placeholderImage: #imageLiteral(resourceName: "PlaceHolderImg"),
                         success: { (smallImgReq, smallImgResponse, smallImg) -> Void in
                            img.alpha = 0.0
                            img.image = smallImg
                            
                            UIView.animate(withDuration: 0.3, animations: {()-> Void in
                                img.alpha = 1.0
                            }, completion: { (success) -> Void in
                                img.setImageWith(largeImgReq, placeholderImage: smallImg,
                                                 success: { (largeImgReq, largeImgResponse, largeImg) in
                                                    img.image = largeImg
                                }, failure: { (request, response, error) in
                                    
                                })
                            })
        }) { (request, response, error) -> Void in
            
        }
    }
    
    //code to customize navigation bar
    override func viewDidAppear(_ animated: Bool) {
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.yellow
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "camera-1")
        imageView.image = image
        navigationItem.titleView = imageView
        navigationItem.title = "Back to NowPlaying Movies"
    }
    
    //code to connect with detailViewController
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
