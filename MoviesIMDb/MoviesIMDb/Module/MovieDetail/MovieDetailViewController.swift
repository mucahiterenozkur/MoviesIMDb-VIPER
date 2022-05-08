//
//  MoviedetailViewController.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 26.04.2022.
//

import UIKit
import Kingfisher

protocol MovieDetailViewControllerProtocol: AnyObject {
    func prepareMovieDetail(movieDetail: MovieDetails)
    func loadSimilarMovies(similarMovies: SimilarMovies)
    func newRequest()
    func prepareNavBar(title: String)
    func performAction()
}

final class MovieDetailViewController: UIViewController {
   
    internal var presenter: MovieDetailPresenterProtocol?
    internal var movieID = String()
    private let detailView: MovieDetailView = MovieDetailView()
    private var dataFetched : ((MovieDetails) -> Void)? = nil
    private static var favs: [String] = []

    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        self.view = detailView
        newRequest()
        presenter?.fetchDetails(movieId: movieID)
        presenter?.fetchSimilars(movieId: movieID)
    }
    
}

extension MovieDetailViewController: MovieDetailViewControllerProtocol {
    
    internal func loadSimilarMovies(similarMovies: SimilarMovies) {
        detailView.similarMoviesArray = similarMovies.results
        detailView.collectionView.reloadData()
    }
    
    internal func prepareMovieDetail(movieDetail: MovieDetails) {
        self.title = movieDetail.title
        detailView.headerLabel.text = movieDetail.title
        detailView.descriptionText.text = movieDetail.overview
        detailView.dateLabel.text = movieDetail.releaseDate
        detailView.ratingLabel.text = String(movieDetail.voteAverage)
        guard let resource = URL(string: Constants.BaseURL.imageBaseURL + (movieDetail.backdropPath ?? movieDetail.posterPath)) else {return}
        let placeholder = UIImage(named: "header")
        detailView.movieImage.kf.setImage(with: resource, placeholder: placeholder)
        detailView.imdbID = movieDetail.imdbID
        prepareNavBar(title: movieDetail.title)
    }
    
    internal func newRequest(){
        detailView.rowTapped = {[weak self] newID in
            guard let self = self else { return }
            self.presenter?.fetchDetails(movieId: newID)
            self.presenter?.fetchSimilars(movieId: newID)
        }
    }
    
    internal func prepareNavBar(title: String) {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: MovieDetailViewController.favs.contains(self.title!) ? UIImage(named: "filledheart") : UIImage(named: "emptyheart"), style: .plain, target: self, action: #selector(performAction))
    }
    
    @objc func performAction() {
        if navigationItem.rightBarButtonItem?.image == UIImage(named: "filledheart") {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "emptyheart"), style: .plain, target: self, action: #selector(performAction))
            MovieDetailViewController.favs = MovieDetailViewController.favs.filter  { $0 != "\(self.title!)" }
        } else {
            navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "filledheart"), style: .plain, target: self, action: #selector(performAction))
            MovieDetailViewController.favs.append(self.title!)
        }
    }

}
