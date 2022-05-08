//
//  MovieDetailRouter.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 26.04.2022.
//

import Foundation
import UIKit

protocol MovieDetailRouterProtocol: AnyObject {

}

final class MovieDetailRouter: NSObject {

    private weak var presenter: MovieDetailPresenterProtocol?

    internal static func createModule() -> MovieDetailViewController {
        let vc = MovieDetailViewController()
        let interactor = MovieDetailInteractor()
        let router = MovieDetailRouter()
        let presenter = MovieDetailPresenter(interactor: interactor, router: router, view: vc)

        vc.presenter = presenter
        router.presenter = presenter
        interactor.output = presenter
        return vc
    }
    
}

extension MovieDetailRouter: MovieDetailRouterProtocol {

}

