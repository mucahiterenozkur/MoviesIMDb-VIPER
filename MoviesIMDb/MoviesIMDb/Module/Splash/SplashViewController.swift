//
//  SplashViewController.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 25.04.2022.
//

import UIKit

protocol SplashViewControllerProtocol: AnyObject {
    func noInternetConnection()
}

final class SplashViewController: BaseViewController {

    public var presenter: SplashPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidAppear()
    }

}

extension SplashViewController: SplashViewControllerProtocol {
    
    internal func noInternetConnection() {
        showAlert(title: "Error", message: "No Internet Connection, Please check your connection")
    }
    
}
