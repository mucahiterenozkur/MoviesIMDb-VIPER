//
//  SearchEntity.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 26.04.2022.
//

import Foundation

// MARK: - SearchMovies
struct SearchMovies: Codable {
    let page, totalResults, totalPages: Int
    let results: [SearchResult]

    enum CodingKeys: String, CodingKey {
        case page
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results
    }
}

// MARK: - Result
struct SearchResult: Codable {
    let posterPath: String?
    let id: Int
    let backdropPath: String?
    let title: String

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case id
        case backdropPath = "backdrop_path"
        case title
    }
}

