//
//  Request.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 25.04.2022.
//

import Foundation

final class Request {
    
    internal static let shared: Request = {
        let instance = Request()
        return instance
    }()

    internal func getUpcomingMovies(page: Int, completionHandler: @escaping (Result<UpcomingMovies, Error>) -> ()) {
        NetworkManager.shared.request(Router.upcoming(page: page), decodeToType: UpcomingMovies.self, completionHandler: completionHandler)
    }
    
    internal func getNowPlayingMovies(completionHandler: @escaping (Result<NowPlayingMovies, Error>) -> ()) {
        NetworkManager.shared.request(Router.nowPlaying, decodeToType: NowPlayingMovies.self, completionHandler: completionHandler)
    }

    internal func searchMovies(query:String, completionHandler: @escaping (Result<SearchMovies, Error>) -> ()) {
        NetworkManager.shared.request(Router.search(query: query), decodeToType: SearchMovies.self, completionHandler: completionHandler)
    }

    internal func movieDetail(movieId: String, completionHandler: @escaping (Result<MovieDetails, Error>) -> ()) {
        NetworkManager.shared.request(Router.details(movieId: movieId), decodeToType: MovieDetails.self, completionHandler: completionHandler)
    }

    internal func similarMovies(movieId: String, completionHandler: @escaping (Result<SimilarMovies, Error>) -> ()) {
        NetworkManager.shared.request(Router.similars(movieId: movieId), decodeToType: SimilarMovies.self, completionHandler: completionHandler)
    }
    
}
