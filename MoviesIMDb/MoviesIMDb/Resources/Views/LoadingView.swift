//
//  LoadingView.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 25.04.2022.
//

import Foundation
import UIKit

final class LoadingView {
    
    private var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    private var blurView: UIVisualEffectView = UIVisualEffectView()
    public static let shared = LoadingView()
    
    private init() {
        configure()
    }

    internal func configure() {
        blurView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        blurView.translatesAutoresizingMaskIntoConstraints = false
        blurView.frame = UIWindow(frame: UIScreen.main.bounds).frame
        activityIndicator.center = blurView.center
        activityIndicator.hidesWhenStopped = true
        blurView.contentView.addSubview(activityIndicator)
    }

    internal func startLoading() {
        UIApplication.shared.windows.first?.addSubview(blurView)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
    }

    internal func hideLoading() {
        blurView.removeFromSuperview()
        activityIndicator.stopAnimating()
    }
    
}
