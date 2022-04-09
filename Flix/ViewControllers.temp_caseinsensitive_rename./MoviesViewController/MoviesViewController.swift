//
//  MoviesViewController.swift
//  Flix
//
//  Created by Pann Cherry on 4/6/22.
//  Copyright © 2022 Pann Cherry. All rights reserved.
//

import UIKit
import AFNetworking
import AlamofireImage

class MoviesViewController: CommonViewController {

    // Properties
    var movies: [Movie] = []
    var filteredMovie:[Movie]!
    var refreshControl: UIRefreshControl!

    // IBOutlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!

    // Life cycles
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchMovies()
        self.addRefreshControl()
        self.initializeTableView()
        self.initializeSearchBar()
        self.addCutsomLeftNavigationTitle(title: "Movies")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.fetchMovies()
    }

    @objc func fetchMovies () {
        NetworkManager.sharedNetworkManager.requestMovies(moviesURL: NetworkManager.nowPlayingURL) {response in
            guard let movies = response.movies else { return }
            self.movies = movies
            self.filteredMovie = movies
            self.tableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }

    private func addRefreshControl() {
        refreshControl = UIRefreshControl()
        tableView.insertSubview(refreshControl, at: 0)
        refreshControl.addTarget(self, action: #selector(self.fetchMovies), for: .valueChanged)
    }

    private func initializeSearchBar() {
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
    }
}


// MARK: UITableView Delegate
extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {

    private func initializeTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: MovieTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: MovieTableViewCell.identifier)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }

        cell.configure(movie: movies[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = MovieDetailViewController(movie: movies[indexPath.row])
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}


// MARK: UISearchBar Delegate
extension MoviesViewController: UISearchBarDelegate {

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.searchTextField.endEditing(true)
        searchBar.searchTextField.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        movies = searchText.isEmpty ? filteredMovie : filteredMovie.filter({ movie -> Bool in
            let dataString = movie.title
            return dataString.lowercased().range(of: searchText.lowercased()) != nil
        })
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
}
