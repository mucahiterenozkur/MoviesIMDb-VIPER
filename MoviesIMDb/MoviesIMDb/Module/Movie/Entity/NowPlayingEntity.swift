//
//  NowPlayingEntity.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 26.04.2022.
//

import Foundation

// MARK: - MovieList
struct NowPlayingMovies: Codable {
    let results: [NowPlayingResult]
    let page, totalResults: Int
    let dates: NowPlayingDates
    let totalPages: Int

    enum CodingKeys: String, CodingKey {
        case results, page
        case totalResults = "total_results"
        case dates
        case totalPages = "total_pages"
    }
}

// MARK: - Dates
struct NowPlayingDates: Codable {
    let maximum, minimum: String
}

// MARK: - Result
struct NowPlayingResult: Codable {
    let video: Bool
    let posterPath: String
    let id: Int
    let backdropPath: String?
    let title: String
    let voteAverage: Double
    let overview, releaseDate: String

    enum CodingKeys: String, CodingKey {
        case video
        case posterPath = "poster_path"
        case id
        case backdropPath = "backdrop_path"
        case title
        case voteAverage = "vote_average"
        case overview
        case releaseDate = "release_date"
    }
}
