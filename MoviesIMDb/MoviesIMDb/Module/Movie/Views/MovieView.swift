//
//  MovieView.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 26.04.2022.
//

import Foundation
import UIKit

final class MovieView: UIView, UIScrollViewDelegate {
    
    internal var movieArray = [UpcomingResult]()
    internal var nowPlayingMovieArray = [NowPlayingResult]()
    internal var searchMovieArray = [SearchResult]()
    internal var rowTapped : ((String) -> Void)? = nil
    internal var searchMovies : ((String) -> Void)? = nil
    fileprivate let cellId = "cellId"
    fileprivate let headerId = "headerId"
    public static var hasLoaded = false

    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        searchBar.backgroundImage = UIImage()
        searchBar.barStyle = .default
        return searchBar
    }()

    internal lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.allowsMultipleSelection = false
        //tableView.separatorColor = .white
        UITableViewCell.appearance().selectionStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    internal lazy var searchTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.allowsMultipleSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.allowsSelection = true
        return tableView
    }()

    internal lazy var searchView : UIView = {
        let view = UIView()
        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    public func loadMore() {
        MovieViewController.currentPage += 1
        MovieViewController.presenter?.fetchNextPage(page: MovieViewController.currentPage)
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height ) && !MovieView.hasLoaded){
            MovieView.hasLoaded = true
            loadMore()
        }
    }
    
}

extension MovieView : SetupView, UISearchBarDelegate, UISearchDisplayDelegate {
    
    internal func buildViewHierarchy() {
        self.addSubviews(searchBar, tableView, searchView)
        self.searchView.addSubview(searchTableView)
    }
    
    internal func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide
        searchBar.anchor(top: safeArea.topAnchor, leading: safeArea.leadingAnchor, bottom: nil, trailing: safeArea.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        tableView.anchor(top: searchBar.bottomAnchor, leading: safeArea.leadingAnchor, bottom: safeArea.bottomAnchor, trailing: safeArea.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        searchView.anchor(top: searchBar.bottomAnchor, leading: safeArea.leadingAnchor, bottom: nil, trailing: safeArea.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 300))
        searchTableView.anchor(top: searchView.topAnchor, leading: searchView.leadingAnchor, bottom: searchView.bottomAnchor, trailing: searchView.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
    }
    
    internal func setupAdditionalConfiguration() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieCell.self, forCellReuseIdentifier: cellId)
        tableView.register(MovieHeaderView.self, forCellReuseIdentifier: headerId)
        searchBar.delegate = self

        searchTableView.delegate = self
        searchTableView.dataSource = self
        searchTableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let movieString = (searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))!
        if (searchBar.text?.count)! > 2 {
            self.searchView.isHidden = false
            if let searchMovies = self.searchMovies {
                searchMovies(String(movieString))
                DispatchQueue.main.async {
                    self.searchTableView.reloadData()
                }
            }
        } else { self.searchView.isHidden = true }
    }
    
}

extension MovieView : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView == self.tableView ? movieArray.count : searchMovieArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == self.tableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MovieCell ?? MovieCell(style: .default, reuseIdentifier: cellId)
            cell.accessoryType = .disclosureIndicator
            cell.configure(movieItem: movieArray[indexPath.row])
            return cell
        } else {
            let cell = self.searchTableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? SearchResultTableViewCell ?? SearchResultTableViewCell(style: .default, reuseIdentifier: cellId)
            cell.accessoryType = .disclosureIndicator
            cell.movieLabel.text = searchMovieArray[indexPath.row].title
            let resource = URL(string: Constants.BaseURL.imageBaseURL + (searchMovieArray[indexPath.row].backdropPath ?? Constants.BaseURL.noImage))
            let placeholder = UIImage(named: "header")
            cell.movieImage.kf.setImage(with: resource, placeholder: placeholder)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tableView == self.tableView ? Constants.Sizes.tableViewCellHeight : Constants.Sizes.searchTableViewCellHeight
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        tableView == self.tableView ? 250 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: headerId) as? MovieHeaderView
        header?.nowPlayingMovieArray = self.nowPlayingMovieArray
        header?.collectionView.reloadData()
        return header
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == self.tableView {
            if let rowTapped = self.rowTapped {
                rowTapped(String(movieArray[indexPath.row].id))
            }
        } else {
            if let rowTapped = self.rowTapped {
                rowTapped(String(searchMovieArray[indexPath.row].id))
            }

        }
    }
    
}
