//
//  MockViewController.swift
//  MoviesIMDbTests
//
//  Created by Mücahit Eren Özkur on 30.04.2022.
//

import Foundation
@testable import MoviesIMDb

final class MockViewController: MovieViewControllerProtocol, MovieDetailViewControllerProtocol {
    
    //MARK: - Movie Module Variables
    var isInvokedloadUpcomingMovies = false
    var isInvokedloadNowPlayingMovies = false
    var isInvokedloadSearchingMovies = false
    var isInvokedgoToDetailsPage = false
    var isInvokedstartSearch = false
    var isInvokedprepareNavBar = false
    
    //MARK: - Movie Detail Module Variables
    var isInvokedprepareMovieDetail = false
    var isInvokedloadSimilarMovies = false
    var isInvokednewRequest = false
    var isInvokedprepareNavBarDetail = false
    var isInvokedperformAction = false
    
    //MARK: - Movie Module Functions
    func loadUpcomingMovies(upcomingMovies: UpcomingMovies) {
        self.isInvokedloadUpcomingMovies = true
    }
    
    func loadNowPlayingMovies(nowPlayingMovies: NowPlayingMovies) {
        self.isInvokedloadNowPlayingMovies = true
    }
    
    func loadSearchingMovies(searchMovies: SearchMovies) {
        self.isInvokedloadSearchingMovies = true
    }
    
    func goToDetailsPage() {
        self.isInvokedgoToDetailsPage = true
    }
    
    func startSearch() {
        self.isInvokedstartSearch = true
    }
    
    func prepareNavBar() {
        self.isInvokedprepareNavBar = true
    }
    
    //MARK: - Movie Detail Module Functions
    func prepareMovieDetail(movieDetail: MovieDetails) {
        self.isInvokedprepareMovieDetail = true
    }
    
    func loadSimilarMovies(similarMovies: SimilarMovies) {
        self.isInvokedloadSimilarMovies = true
    }
    
    func newRequest() {
        self.isInvokednewRequest = true
    }
    
    func prepareNavBar(title: String) {
        self.isInvokedprepareNavBarDetail = true
    }
    
    func performAction() {
        self.isInvokedperformAction = true
    }
    
}
