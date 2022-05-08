//
//  Router.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 25.04.2022.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    case nowPlaying
    case upcoming(page: Int)
    case search(query: String)
    case details(movieId: String)
    case similars(movieId: String)
    
    var method: HTTPMethod {
        switch self {
        case .nowPlaying:
            return .get
        case .upcoming:
            return .get
        case .search:
            return .get
        case .details:
            return .get
        case .similars:
            return .get
        }
    }
    
    var parameters: [String : Any]? {
        switch self {
        case .nowPlaying:
            return nil
        case .upcoming:
            return nil
        case .search:
            return nil
        case .details:
            return nil
        case .similars:
            return nil
        }
    }
    
    var url: URL {
        switch self {
        case .nowPlaying:
            let url = URL(string: Constants.BaseURL.nowPlayingURL)!
            return url
        case .upcoming(let page):
            let url = URL(string: "\(Constants.BaseURL.upcomingURL)\(page)")!
            return url
        case .search(let query):
            let queryString = Constants.BaseURL.searchURL + query
            let url = URL(string: queryString)!
            return url
        case .details(let movieId):
            let queryString = Constants.BaseURL.baseURL + movieId + Constants.BaseURL.detailString
            let url = URL(string: queryString)!
            return url
        case .similars(let movieId):
            let queryString = Constants.BaseURL.baseURL + movieId + "/similar" + Constants.BaseURL.detailString
            let url = URL(string: queryString)!
            return url
        }
    }
    
    var encoding: ParameterEncoding {
        return JSONEncoding.default
    }
    
    internal func asURLRequest() throws -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        return try encoding.encode(urlRequest, with: parameters)
    }
    
}
