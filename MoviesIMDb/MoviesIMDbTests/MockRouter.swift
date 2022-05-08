//
//  MockRouter.swift
//  MoviesIMDbTests
//
//  Created by Mücahit Eren Özkur on 30.04.2022.
//

import Foundation
@testable import MoviesIMDb

final class MockRouter: MovieRouterProtocol {
    
    var isInvokedNavigateToDetailWith = false
    
    func navigateToDetailWith(movieID: String) {
        self.isInvokedNavigateToDetailWith = true
    }
    
}
