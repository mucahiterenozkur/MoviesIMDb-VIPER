//
//  LoadingShowable.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 25.04.2022.
//

import UIKit

protocol LoadingShowable where Self: UIViewController {
    func showLoading()
    func hideLoading()
}

extension LoadingShowable {
    internal func showLoading() {
        LoadingView.shared.startLoading()
    }

    internal func hideLoading() {
        LoadingView.shared.hideLoading()
    }
}
