//
//  MovieViewController.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 25.04.2022.
//

import UIKit

protocol MovieViewControllerProtocol: AnyObject {
    func loadUpcomingMovies(upcomingMovies: UpcomingMovies)
    func loadNowPlayingMovies(nowPlayingMovies: NowPlayingMovies)
    func loadSearchingMovies(searchMovies: SearchMovies)
    func goToDetailsPage()
    func startSearch()
    func prepareNavBar()
}

final class MovieViewController: UIViewController {
    
    internal static var presenter: MoviePresenterProtocol?
    private let movieView: MovieView = MovieView()
    private let notificationCenter = NotificationCenter.default
    public static var currentPage = 1
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = movieView
        hideKeyboardWhenTappedAround()
        goToDetailsPage()
        startSearch()
        prepareNavBar()
        MovieViewController.presenter?.viewDidAppear(page: MovieViewController.currentPage)
    }
    
}

extension MovieViewController: MovieViewControllerProtocol {
    
    internal func loadSearchingMovies(searchMovies: SearchMovies) {
        self.movieView.searchMovieArray = searchMovies.results
        DispatchQueue.main.async {
            self.movieView.searchTableView.reloadData()
        }
    }
    
    internal func loadNowPlayingMovies(nowPlayingMovies: NowPlayingMovies) {
        movieView.nowPlayingMovieArray = nowPlayingMovies.results
    }
    
    internal func loadUpcomingMovies(upcomingMovies: UpcomingMovies) {
        guard let movies = upcomingMovies.results else { return }
        self.movieView.movieArray.append(contentsOf: movies)
        DispatchQueue.main.async { self.movieView.tableView.reloadData() }
    }
    
    @objc func startSearch(){
        movieView.searchMovies = { movieKeyword in
            MovieViewController.presenter?.searchingMovies(query: movieKeyword)
        }
    }
    
    internal func goToDetailsPage(){
        movieView.rowTapped = {[weak self] movieID in
            guard self != nil else { return }
            MovieViewController.presenter?.rowTapped(movieID: movieID)
        }
    }
    
    internal func prepareNavBar() {
        let backItem = UIBarButtonItem()
        backItem.title = ""
        backItem.tintColor = Constants.Colors.backItemColor
        self.navigationItem.backBarButtonItem = backItem
    }
    
}
