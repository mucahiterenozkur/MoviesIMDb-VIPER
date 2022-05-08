//
//  MoviePresenter.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 25.04.2022.
//

import Foundation

protocol MoviePresenterProtocol: AnyObject {
    func viewDidAppear(page: Int)
    func searchingMovies(query: String)
    func rowTapped(movieID: String)
    func fetchNextPage(page: Int)
}

final class MoviePresenter {

    private unowned var view: MovieViewControllerProtocol
    private let router: MovieRouterProtocol?
    private let interactor: MovieInteractorProtocol?

    init(interactor: MovieInteractorProtocol, router: MovieRouterProtocol, view: MovieViewControllerProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension MoviePresenter: MoviePresenterProtocol {
    
    internal func viewDidAppear(page: Int) {
        DispatchQueue.main.async {
            self.interactor?.fetchUpcomingMovies(page: page)
            self.interactor?.fetchNowPlayingMovies()
        }
    }

    internal func searchingMovies(query: String) {
        DispatchQueue.main.async {
            self.interactor?.fetchSearchMovies(query: query)
        }
    }
    
    internal func rowTapped(movieID: String) {
        router?.navigateToDetailWith(movieID: movieID)
    }
    
    internal func fetchNextPage(page: Int) {
        DispatchQueue.main.async {
            self.interactor?.fetchUpcomingMovies(page: page)
        }
    }
    
}

extension MoviePresenter: MovieListInteractorOutputProtocol {
    
    internal func searchingMoviesFetchedSuccessfully(movies: SearchMovies) {
        view.loadSearchingMovies(searchMovies: movies)
    }
    
    internal func searchingMoviesFetchingFailed(withError error: Error) {
        print(error.localizedDescription)
    }
    
    internal func nowPlayingMoviesFetchedSuccessfully(movies: NowPlayingMovies) {
        view.loadNowPlayingMovies(nowPlayingMovies: movies)
    }
    
    internal func nowPlayingMoviesFetchingFailed(withError error: Error) {
        print(error.localizedDescription)
    }
    
    internal func upcomingMoviesFetchedSuccessfully(movies: UpcomingMovies) {
        view.loadUpcomingMovies(upcomingMovies: movies)
    }
    
    internal func upcomingMoviesFetchingFailed(withError error: Error) {
        print(error.localizedDescription)
    }
    
}
