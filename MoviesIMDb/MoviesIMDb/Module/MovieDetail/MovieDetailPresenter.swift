//
//  MovieDetailPresenter.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 26.04.2022.
//

import Foundation

protocol MovieDetailPresenterProtocol: AnyObject {
    func fetchDetails(movieId: String)
    func fetchSimilars(movieId: String)
}

final class MovieDetailPresenter {

    private unowned var view: MovieDetailViewControllerProtocol
    private let router: MovieDetailRouterProtocol?
    private let interactor: MovieDetailInteractorProtocol?
    
    init(interactor: MovieDetailInteractorProtocol, router: MovieDetailRouterProtocol, view: MovieDetailViewControllerProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension MovieDetailPresenter: MovieDetailPresenterProtocol {
    
    internal func fetchDetails(movieId: String) {
        self.interactor?.fetchMovieDetails(movieId: movieId)
    }
    
    internal func fetchSimilars(movieId: String) {
        DispatchQueue.main.async {
            self.interactor?.fetchSimilarMovies(movieId: movieId)
        }
    }
    
}

extension MovieDetailPresenter: MovieDetailInteractorOutputProtocol {
    
    internal func similarMoviesFetchedSuccessfully(similars: SimilarMovies) {
        view.loadSimilarMovies(similarMovies: similars)
    }
    
    internal func similarMoviesFetchingFailed(withError error: Error) {
        debugPrint(error)
    }
    
    internal func movieDetailFetchedSuccessfully(details: MovieDetails) {
        view.prepareMovieDetail(movieDetail: details)
    }
    
    internal func movieDetailFetchingFailed(withError error: Error) {
        debugPrint(error)
    }
}
