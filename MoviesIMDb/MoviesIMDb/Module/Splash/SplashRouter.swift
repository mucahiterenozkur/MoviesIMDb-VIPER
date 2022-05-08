//
//  SplashRouter.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 25.04.2022.
//

import Foundation
import UIKit

protocol SplashRouterProtocol: AnyObject {
    func navigate(_ route: SplashRoutes)
}

enum SplashRoutes {
    case homeScreen
}

final class SplashRouter {
    
    private weak var viewController: SplashViewController?
    
    public static func createModule() -> SplashViewController {
        let view = SplashViewController()
        let interactor = SplashInteractor()
        let router = SplashRouter()
        let presenter = SplashPresenter(view: view, router: router, interactor: interactor)
        view.presenter = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
    
}

extension SplashRouter: SplashRouterProtocol {
    
    internal func navigate(_ route: SplashRoutes) {
        
        switch route {
        case .homeScreen:
            guard let window = viewController?.view.window else { return }
            let homeVC = MovieRouter.createModule()
            let navigationController = UINavigationController(rootViewController: homeVC)
            window.rootViewController = navigationController
        }
        
    }
    
}
