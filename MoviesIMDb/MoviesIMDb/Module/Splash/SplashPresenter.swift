//
//  SplashPresenter.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 25.04.2022.
//

import Foundation

protocol SplashPresenterProtocol: AnyObject {
    func viewDidAppear()
}

final class SplashPresenter: SplashPresenterProtocol {
   
    private unowned var view: SplashViewControllerProtocol!
    private let router: SplashRouterProtocol!
    private let interactor: SplashInteractorProtocol!
    
    init(view: SplashViewControllerProtocol, router: SplashRouterProtocol, interactor: SplashInteractorProtocol ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    internal func viewDidAppear() {
        interactor.checkInternetConnection()
    }
    
}

extension SplashPresenter: SplashInteractorOutputProtocol {
    
    internal func internetConnection(status: Bool) {
        
        if status {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) { self.router.navigate(.homeScreen) }
        } else {
            view.noInternetConnection()
        }
        
    }

}
