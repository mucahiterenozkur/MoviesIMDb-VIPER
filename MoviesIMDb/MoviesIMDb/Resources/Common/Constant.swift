//
//  Constant.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 25.04.2022.
//

import Foundation
import UIKit

struct Constants {
    
    struct Fonts {
        static let defaultFont: UIFont = UIFont.systemFont(ofSize: 17, weight: .regular)
        static let descriptionFont: UIFont = UIFont.systemFont(ofSize: 12, weight: .regular)
        static let headerFont: UIFont = UIFont.systemFont(ofSize: 20, weight: .heavy)
        static let dateFont: UIFont = UIFont.systemFont(ofSize: 12, weight: .thin)
        static let searchResultFont: UIFont = UIFont.systemFont(ofSize: 17, weight: .medium)
    }
    
    struct Sizes {
        static let tableViewCellHeight: CGFloat = 150
        static let searchTableViewCellHeight: CGFloat = 50
        static let collectionViewCellSize: CGFloat = 162.0
        static let sizeOfScreen = UIScreen.main.bounds.size
    }
    
    struct Colors {
        static let mainTextColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        static let descriptionTextColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        static let headerTextColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let backItemColor = #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1)
    }
    
    struct BaseURL {
        static let baseURL: String = "https://api.themoviedb.org/3/movie/"
        static let imageBaseURL : String = "https://image.tmdb.org/t/p/w500/"
        static let noImage : String = ""
        static let apiKey : String = "931f1ebe768fe7d9995b93ceb5943ed5"
        static let nowPlayingURL: String = "https://api.themoviedb.org/3/movie/now_playing?api_key=" + apiKey + "&language=en-US&page=1"
        static let upcomingURL: String = "https://api.themoviedb.org/3/movie/upcoming?api_key=" + apiKey + "&language=en-US&page="
        static let searchURL: String = "https://api.themoviedb.org/3/search/movie?api_key=" + apiKey + "&language=en-US&page=1&include_adult=false&query="
        static let detailString: String = "?api_key=" + apiKey + "&language=en-US"
    }

}
