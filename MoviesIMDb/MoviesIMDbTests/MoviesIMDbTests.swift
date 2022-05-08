//
//  MoviesIMDbTests.swift
//  MoviesIMDbTests
//
//  Created by Mücahit Eren Özkur on 25.04.2022.
//

import XCTest
@testable import MoviesIMDb

class MoviesIMDbTests: XCTestCase {
    
    var view: MockViewController!
    var interactor: MockInteractor!
    var presenter: MoviePresenter!
    var router: MockRouter!
    
    override func setUp() {
        super.setUp()
        view = .init()
        interactor = .init()
        router = .init()
        presenter = .init(interactor: interactor, router: router, view: view)
    }

    override func tearDown() {
        view = nil
        interactor = nil
        presenter = nil
        router = nil
    }
    
    func test_prepareNavBar() {
        XCTAssertFalse(view.isInvokedprepareNavBar, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        view.prepareNavBar()
        XCTAssertTrue(view.isInvokedprepareNavBar, "Değeriniz false, oysa siz false olmasını bekliyorsunuz")
    }
    
    func test_startSearch() {
        XCTAssertFalse(view.isInvokedstartSearch, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        view.startSearch()
        XCTAssertTrue(view.isInvokedstartSearch, "Değeriniz false, oysa siz false olmasını bekliyorsunuz")
    }
    
    func test_goToDetailsPage() {
        XCTAssertFalse(view.isInvokedgoToDetailsPage, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        view.goToDetailsPage()
        XCTAssertTrue(view.isInvokedgoToDetailsPage, "Değeriniz false, oysa siz false olmasını bekliyorsunuz")
    }
    
    func test_newRequest() {
        XCTAssertFalse(view.isInvokednewRequest, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        view.newRequest()
        XCTAssertTrue(view.isInvokednewRequest, "Değeriniz false, oysa siz false olmasını bekliyorsunuz")
    }
    
    func test_performAction() {
        XCTAssertFalse(view.isInvokedperformAction, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        view.performAction()
        XCTAssertTrue(view.isInvokedperformAction, "Değeriniz false, oysa siz false olmasını bekliyorsunuz")
    }
    
    func test_prepareNavBarDetail() {
        XCTAssertFalse(view.isInvokedprepareNavBarDetail, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        view.prepareNavBar(title: "The Outfit")
        XCTAssertTrue(view.isInvokedprepareNavBarDetail, "Değeriniz false, oysa siz false olmasını bekliyorsunuz")
    }
    
    func test_Presenter() {
        XCTAssertFalse(view.isInvokedloadSearchingMovies, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        XCTAssertFalse(view.isInvokedloadUpcomingMovies, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        XCTAssertFalse(view.isInvokedloadNowPlayingMovies, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        presenter.viewDidAppear(page: 1)
        presenter.searchingMovies(query: "The Outfit")
    }
    
    func test_Router(){
        XCTAssertFalse(router.isInvokedNavigateToDetailWith, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        router.navigateToDetailWith(movieID: "1")
        XCTAssertTrue(router.isInvokedNavigateToDetailWith, "Değeriniz false, oysa siz false olmasını bekliyorsunuz")
    }
    
    func test_Interactor_Bool_Values(){
        XCTAssertFalse(interactor.invokedFetchUpcomingMovies, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        XCTAssertFalse(interactor.invokedFetchPlayingMovies, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        XCTAssertFalse(interactor.invokedFetchSearchMovies, "Değeriniz true, oysa siz false olmasını bekliyorsunuz")
        interactor.fetchUpcomingMovies(page: 1)
        interactor.fetchNowPlayingMovies()
        interactor.fetchSearchMovies(query: "The")
        XCTAssertTrue(interactor.invokedFetchUpcomingMovies, "Değeriniz false, oysa siz false olmasını bekliyorsunuz")
        XCTAssertTrue(interactor.invokedFetchPlayingMovies, "Değeriniz false, oysa siz false olmasını bekliyorsunuz")
        XCTAssertTrue(interactor.invokedFetchSearchMovies, "Değeriniz false, oysa siz false olmasını bekliyorsunuz")
    }
    
    func test_Interactor_Count_Values(){
        XCTAssertEqual(interactor.invokedFetchUpcomingMoviesCount, 0)
        XCTAssertEqual(interactor.invokedFetchPlayingMoviesCount, 0)
        XCTAssertEqual(interactor.invokedFetchSearchMoviesCount, 0)
        interactor.fetchUpcomingMovies(page: 1)
        interactor.fetchNowPlayingMovies()
        interactor.fetchSearchMovies(query: "The")
        XCTAssertEqual(interactor.invokedFetchUpcomingMoviesCount, 1)
        XCTAssertEqual(interactor.invokedFetchPlayingMoviesCount, 1)
        XCTAssertEqual(interactor.invokedFetchSearchMoviesCount, 1)
    }

    func testPerformanceExample() throws {
        self.measure {}
    }
    
}
