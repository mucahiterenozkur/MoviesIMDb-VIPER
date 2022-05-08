//
//  MovieHeaderView.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 26.04.2022.
//

import UIKit

final class MovieHeaderView: UITableViewCell {
    
    private let cellId = "cellId"
    internal var nowPlayingMovieArray = [NowPlayingResult]()
    
    internal var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.isPagingEnabled = true
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        layout.minimumLineSpacing = 0
        return cv
    }()

    private lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.backgroundColor = .clear
        pc.currentPage = 0
        pc.numberOfPages = 20
        pc.pageIndicatorTintColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        pc.currentPageIndicatorTintColor = .systemBlue
        pc.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        return pc
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: cellId)
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTimerForHeader() {
        Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { timer in
            self.pageControl.currentPage += 1
            let indexPath = IndexPath(item: self.pageControl.currentPage, section: 0)
            self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    
}

extension MovieHeaderView : SetupView {
    
    internal func buildViewHierarchy() {
        self.addSubviews(collectionView, pageControl)
    }
    
    internal func setupConstraints() {
        collectionView.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        pageControl.anchor(top: nil, leading: nil, bottom: self.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 0, bottom: 5, right: 0))
        pageControl.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    internal func setupAdditionalConfiguration() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MovieHeaderCell.self, forCellWithReuseIdentifier: cellId)
    }
    
}

extension MovieHeaderView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        nowPlayingMovieArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MovieHeaderCell
        setTimerForHeader()
        cell.headerCellConfigure(movieItem: nowPlayingMovieArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: Constants.Sizes.collectionViewCellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
