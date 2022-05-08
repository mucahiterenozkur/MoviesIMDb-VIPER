//
//  MockInteractor.swift
//  MoviesIMDbTests
//
//  Created by Mücahit Eren Özkur on 30.04.2022.
//

import Foundation
@testable import MoviesIMDb

final class MockInteractor: MovieInteractorProtocol {
    
    var invokedFetchUpcomingMovies = false
    var invokedFetchPlayingMovies = false
    var invokedFetchSearchMovies = false
    
    var invokedFetchUpcomingMoviesCount = 0
    var invokedFetchPlayingMoviesCount = 0
    var invokedFetchSearchMoviesCount = 0
    
    
    func fetchUpcomingMovies(page: Int) {
        self.invokedFetchUpcomingMovies = true
        self.invokedFetchUpcomingMoviesCount += 1
    }
    
    func fetchNowPlayingMovies() {
        self.invokedFetchPlayingMovies = true
        self.invokedFetchPlayingMoviesCount += 1
    }
    
    func fetchSearchMovies(query: String) {
        self.invokedFetchSearchMovies = true
        self.invokedFetchSearchMoviesCount += 1
    }
    
}
