//
//  MovieInteractor.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 25.04.2022.
//

import Foundation

protocol MovieInteractorProtocol: AnyObject {
    func fetchUpcomingMovies(page: Int)
    func fetchNowPlayingMovies()
    func fetchSearchMovies(query: String)
}

protocol MovieListInteractorOutputProtocol: AnyObject {
    func upcomingMoviesFetchedSuccessfully(movies: UpcomingMovies)
    func upcomingMoviesFetchingFailed(withError error: Error)
    func nowPlayingMoviesFetchedSuccessfully(movies: NowPlayingMovies)
    func nowPlayingMoviesFetchingFailed(withError error: Error)
    func searchingMoviesFetchedSuccessfully(movies: SearchMovies)
    func searchingMoviesFetchingFailed(withError error: Error)
}

final class MovieInteractor {
    internal weak var output: MovieListInteractorOutputProtocol?
}

extension MovieInteractor: MovieInteractorProtocol {
    
    internal func fetchSearchMovies(query: String) {
        Request.shared.searchMovies(query: query) { [weak self] result in
            guard let self = self else { return }
                switch result {
                case .success(let movies):
                    self.output?.searchingMoviesFetchedSuccessfully(movies: movies)
                case .failure(let error):
                    self.output?.searchingMoviesFetchingFailed(withError: error)
            }
        }

    }
    
    internal func fetchNowPlayingMovies() {
        Request.shared.getNowPlayingMovies { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let movies):
                self?.output?.nowPlayingMoviesFetchedSuccessfully(movies: movies)
            case .failure(let error):
                self?.output?.nowPlayingMoviesFetchingFailed(withError: error)
            }
        }
    }
    
    internal func fetchUpcomingMovies(page: Int) {
        Request.shared.getUpcomingMovies(page: page) { [weak self] result in
            guard self != nil else { return }
            switch result {
            case .success(let movies):
                self?.output?.upcomingMoviesFetchedSuccessfully(movies: movies)
            case .failure(let error):
                self?.output?.upcomingMoviesFetchingFailed(withError: error)
            }
            MovieView.hasLoaded = false
        }
    }
    
}


