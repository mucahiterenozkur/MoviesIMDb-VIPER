//
//  MovieRouter.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 25.04.2022.
//

import Foundation

protocol MovieRouterProtocol {
    func navigateToDetailWith(movieID: String)
}

final class MovieRouter: NSObject {

    private weak var presenter: MoviePresenterProtocol?
    private weak var viewController: MovieViewController?
    
    internal static func createModule() -> MovieViewController {
        let vc = MovieViewController()
        let interactor = MovieInteractor()
        let router = MovieRouter()
        let presenter = MoviePresenter(interactor: interactor, router: router, view: vc)

        MovieViewController.presenter = presenter
        router.presenter = presenter
        interactor.output = presenter
        router.viewController = vc
        return vc
    }
    
}

extension MovieRouter: MovieRouterProtocol {
    
    internal func navigateToDetailWith(movieID: String) {
        let vc = MovieDetailRouter.createModule()
        vc.movieID = movieID
        viewController?.navigationController?.pushViewController(vc, animated: true)
    }
    
}
