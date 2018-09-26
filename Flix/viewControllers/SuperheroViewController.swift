//
//  SuperheroViewController.swift
//  Flix
//
//  Created by Pann Cherry on 9/11/18.
//  Copyright © 2018 Pann Cherry. All rights reserved.
//

import UIKit

class SuperheroViewController: UIViewController, UICollectionViewDataSource, UISearchBarDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var refreshControl: UIRefreshControl!
    
    var filteredMovie:[[String: Any]]!
    
    var movies: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        searchBar.delegate = self
        //searchBar.becomeFirstResponder()
        refreshControl = UIRefreshControl()
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        let cellPerLine: CGFloat = 2
        let interItemSpacingTotal = layout.minimumLineSpacing * (cellPerLine - 1)
        let width = collectionView.frame.size.width/cellPerLine - interItemSpacingTotal/cellPerLine
        layout.itemSize = CGSize(width: width, height: width*3/2)
        
        
        self.activityIndicator.startAnimating()
        
        //code to display the activityIndicator for desired seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.refreshScreen()
        }
    }
    
    //code to count movies
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    //code to create cell and insert poster image using url and poster_path
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.item]
        if let posterPathString = movie["poster_path"] as? String {
            /*
             let baseURLString = "https://image.tmdb.org/t/p/w500"
             let posterURL = URL(string: baseURLString + posterPathString)!
             cell.posterImageView.af_setImage(withURL: posterURL)
             */
            let smallPosterPath = "https://image.tmdb.org/t/p/w45"
            let largePosterPath = "https://image.tmdb.org/t/p/original"
            imageLoad(smallImgURL: smallPosterPath + posterPathString, largeImgURL: largePosterPath + posterPathString, img: cell.posterImageView)
        }
        return cell
    }
    
    public override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape,
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = view.frame.height - 22
            layout.itemSize = CGSize(width: width - 16, height: 260)
            layout.invalidateLayout()
        } else if UIDevice.current.orientation.isPortrait,
            let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let width = view.frame.width - 22
            layout.itemSize = CGSize(width: width - 16, height: 260)
            layout.invalidateLayout()
        }
    }
    
    //code to fetche now playing movies
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
                self.collectionView.reloadData()
                self.refreshControl.endRefreshing()
                self.activityIndicator.stopAnimating()
            }
        }
        //starts the task
        task.resume()
    }
    
    //code to refresh the network and fetch the movies
    func refreshScreen(){
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(NowPlayingViewController.didPullToRefresh(_:)), for: .valueChanged)
        collectionView.insertSubview(refreshControl, at: 0)
        collectionView.dataSource = self
        fetchMovies()
    }
    
    //code to refresh the page and fetch movies
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl) {
        fetchMovies()
    }
    
    // code to update filteredMovie based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movies = searchText.isEmpty ? filteredMovie : filteredMovie.filter { ($0["title"] as! String).lowercased().contains(searchBar.text!.lowercased()) }
        collectionView.reloadData()
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
        navigationItem.title = "Back"
    }
    
    //code to connect with PosterDetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        if let indexPath = collectionView.indexPath(for: cell){
            let movie = movies[indexPath.row]
            let posterDetailViewController = segue.destination as! PosterDetailViewController
            posterDetailViewController.movie = movie
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
