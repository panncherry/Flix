//
//  PopularMoviesViewController.swift
//  Flix
//
//  Created by Pann Cherry on 4/7/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit

class PopularMoviesViewController: CommonViewController {

    // IBOutlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var segmentedControl: PillSegmentedControl!
    @IBOutlet weak var collectionView: UICollectionView!

    // Properties
    var movies: [Movie] = []
    var filteredMovie:[Movie] = []
    var selectedGenre: GenreType? = .all
    var refreshControl: UIRefreshControl = UIRefreshControl()

    var selectedSegmentIndex: Int = 0 {
        didSet {
            if self.selectedSegmentIndex == 0 { self.selectedGenre = .all }
            if self.selectedSegmentIndex == 1 { self.selectedGenre = .adventure }
            if self.selectedSegmentIndex == 2 { self.selectedGenre = .animation }
            if self.selectedSegmentIndex == 3 { self.selectedGenre = .action }
            if self.selectedSegmentIndex == 4 { self.selectedGenre = .comedy }
            if self.selectedSegmentIndex == 5 { self.selectedGenre = .crime }
            if self.selectedSegmentIndex == 5 { self.selectedGenre = .documentary }
            if self.selectedSegmentIndex == 7 { self.selectedGenre = .drama }
            if self.selectedSegmentIndex == 8 { self.selectedGenre = .family }
            if self.selectedSegmentIndex == 9 { self.selectedGenre = .fantasy }
            if self.selectedSegmentIndex == 10 { self.selectedGenre = .history }
            if self.selectedSegmentIndex == 11 { self.selectedGenre = .horror }
            if self.selectedSegmentIndex == 12 { self.selectedGenre = .music }
            if self.selectedSegmentIndex == 13 { self.selectedGenre = .mystery }
            if self.selectedSegmentIndex == 14 { self.selectedGenre = .romance }
            if self.selectedSegmentIndex == 15 { self.selectedGenre = .scienceFiction }
            if self.selectedSegmentIndex == 16 { self.selectedGenre = .tvMovie }
            if self.selectedSegmentIndex == 17 { self.selectedGenre = .thriller }
            if self.selectedSegmentIndex == 18 { self.selectedGenre = .war }
            if self.selectedSegmentIndex == 19 { self.selectedGenre = .western }
            self.fetchMovies()
        }
    }

    // Life Cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addRefreshControl()
        self.searchBar.delegate = self
        self.initializeCollectionView()
        self.addCutsomLeftNavigationTitle(title: "Popular Movies")
        collectionView.reloadData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchMovies()
    }

    // Helpers
    @objc func fetchMovies () {
        NetworkManager.sharedNetworkManager.requestMovies(moviesURL: APIManager.popularMoviesURL) { response in

            guard let movies = response.movies else { return }

            guard let selectedGenre = self.selectedGenre, selectedGenre != .all else {
                self.updateMovies(movies)
                return
            }

            var selectedMovies: [Movie] = []
            for movie in movies {
                for id in movie.genreIds {
                    if id.type == selectedGenre {
                        selectedMovies.append(movie)
                    }
                }
            }
            self.updateMovies(selectedMovies)
            return
        }
    }

    internal func updateMovies(_ movies: [Movie]) {
        self.movies = movies
        self.filteredMovie = movies
        self.collectionView.reloadData()
        self.refreshControl.endRefreshing()
    }

    func addRefreshControl(){
        collectionView.insertSubview(refreshControl, at: 0)
        refreshControl.addTarget(self, action: #selector(self.fetchMovies), for: .valueChanged)
    }

    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        self.selectedSegmentIndex = sender.selectedSegmentIndex

        searchBar.text = ""
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
    }
}

// MARK: UICollectionView DataSource
extension PopularMoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    internal func initializeCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: MoviePosterCollectionViewCell.nibName, bundle: nil), forCellWithReuseIdentifier: MoviePosterCollectionViewCell.identifier)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviePosterCollectionViewCell.identifier, for: indexPath) as? MoviePosterCollectionViewCell, self.movies.count > 0 else {
            return UICollectionViewCell()
        }

        cell.posterImageView.loadImage(for: self.movies[indexPath.row])
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.row]
        self.navigationController?.pushViewController(MovieDetailViewController(movie: selectedMovie), animated: true)
    }

    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
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
}


// MARK: UICollectionView Flow Layout
extension PopularMoviesViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 8.0, bottom: 1.0, right: 8.0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        let widthPerItem = collectionView.frame.width / 2 - layout.minimumInteritemSpacing
        return CGSize(width: widthPerItem - 4, height: 250)
    }
}


// MARK: Search Bar Delegate
extension PopularMoviesViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movies = searchText.isEmpty ? filteredMovie : filteredMovie.filter({ movie -> Bool in
            let dataString = movie.title
            return dataString.lowercased().range(of: searchText.lowercased()) != nil
        })
        collectionView.reloadData()
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
        fetchMovies()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        fetchMovies()
        searchBar.resignFirstResponder()
    }
}
