//
//  MovieDetailInteractor.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 26.04.2022.
//

import Foundation

protocol MovieDetailInteractorProtocol: AnyObject {
    func fetchMovieDetails(movieId: String)
    func fetchSimilarMovies(movieId: String)
}

protocol MovieDetailInteractorOutputProtocol: AnyObject {
    func movieDetailFetchedSuccessfully(details: MovieDetails)
    func movieDetailFetchingFailed(withError error: Error)
    func similarMoviesFetchedSuccessfully(similars: SimilarMovies)
    func similarMoviesFetchingFailed(withError error: Error)
}

final class MovieDetailInteractor {
    internal weak var output: MovieDetailInteractorOutputProtocol?
}

extension MovieDetailInteractor: MovieDetailInteractorProtocol {
   
    internal func fetchSimilarMovies(movieId: String) {
        DispatchQueue.main.async {
            Request.shared.similarMovies(movieId: movieId) { [weak self] result in
                guard self != nil else { return }
                switch result {
                case .success(let similars):
                    self?.output?.similarMoviesFetchedSuccessfully(similars: similars)
                case .failure(let error):
                    self?.output?.similarMoviesFetchingFailed(withError: error)
                }
            }
        }
    }
    
    internal func fetchMovieDetails(movieId: String) {
        Request.shared.movieDetail(movieId: movieId) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let details):
                self?.output?.movieDetailFetchedSuccessfully(details: details)
            case .failure(let error):
                self?.output?.movieDetailFetchingFailed(withError: error)
            }
        }
    }

}
