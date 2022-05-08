//
//  MovieDetailView.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 26.04.2022.
//

import UIKit

final class MovieDetailView: UIView {
    private let cellId = "cellId"
    internal var similarMoviesArray = [SimilarMoviesResult]()
    internal var imdbID = ""
    internal var rowTapped : ((String) -> Void)? = nil

    internal lazy var movieImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.layer.masksToBounds = true
        iv.image = UIImage(named: "header")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    internal lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byWordWrapping
        label.text = "Loading..."
        label.textColor = Constants.Colors.mainTextColor
        label.font = Constants.Fonts.headerFont
        return label
    }()
    
    internal lazy var descriptionText: UITextView = {
        let textView = UITextView()
        textView.isSelectable = false
        textView.textColor = Constants.Colors.descriptionTextColor
        textView.font = Constants.Fonts.defaultFont
        return textView
    }()

    internal lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.descriptionTextColor
        label.text = "Loading..."
        label.font = Constants.Fonts.dateFont
        return label
    }()

    internal lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.descriptionTextColor
        label.font = Constants.Fonts.dateFont
        return label
    }()
    
    internal lazy var ratingImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "rating")
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    internal var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.isPagingEnabled = true
        return cv
    }()

    internal lazy var imdbButton:UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named:"imdb"), for: .normal)
        button.addTarget(self, action: #selector(goToIMDB), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented")}
    
    @objc func goToIMDB(){
        if let url = URL(string: "https://www.imdb.com/title/" + imdbID) {
            UIApplication.shared.open(url, options: [:])
        }
    }

}

extension MovieDetailView: SetupView {
    
    internal func buildViewHierarchy() {
        self.addSubviews(movieImage, headerLabel, descriptionText, dateLabel, imdbButton, ratingLabel, collectionView, ratingImage)
    }
    
    internal func setupConstraints() {
        let safeArea = self.safeAreaLayoutGuide

        movieImage.anchor(top: safeArea.topAnchor, leading: safeArea.leadingAnchor, bottom: nil, trailing: safeArea.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: Constants.Sizes.sizeOfScreen.height <= 568 ? 180 : 240))
        
        headerLabel.anchor(top: movieImage.bottomAnchor, leading: safeArea.leadingAnchor, bottom: nil, trailing: safeArea.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 20))
        
        descriptionText.anchor(top: headerLabel.bottomAnchor, leading: safeArea.leadingAnchor, bottom: nil, trailing: safeArea.trailingAnchor, padding: .init(top: 10, left: 20, bottom: 0, right: 20))
        
        imdbButton.anchor(top: descriptionText.bottomAnchor, leading: nil, bottom: nil, trailing: safeArea.trailingAnchor, padding: .init(top: 5, left: 0, bottom: 0, right: 20),size: .init(width: 50, height: 25))
        
        dateLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: imdbButton.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 20))
        dateLabel.centerYAnchor.constraint(equalTo: imdbButton.centerYAnchor).isActive = true
        
        ratingLabel.anchor(top: nil, leading: nil, bottom: nil, trailing: dateLabel.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 20))
        ratingLabel.centerYAnchor.constraint(equalTo: imdbButton.centerYAnchor).isActive = true
        
        ratingImage.anchor(top: nil, leading: nil, bottom: nil, trailing: ratingLabel.leadingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 5), size: .init(width: 15, height: 15))
        ratingImage.centerYAnchor.constraint(equalTo: imdbButton.centerYAnchor).isActive = true
        
        collectionView.anchor(top: imdbButton.bottomAnchor, leading: safeArea.leadingAnchor, bottom: safeArea.bottomAnchor, trailing: safeArea.trailingAnchor, padding: .init(top: 10, left: 0, bottom: 20, right: 0),size: .init(width: 0, height: (Constants.Sizes.sizeOfScreen.height <= 568) ? 100 : 150))
    }
    
    internal func setupAdditionalConfiguration() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(SimilarMoviesCollectionViewCell.self, forCellWithReuseIdentifier: cellId)
    }
    
}

extension MovieDetailView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        similarMoviesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SimilarMoviesCollectionViewCell
        cell.configure(similarMovie: similarMoviesArray[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let rowTapped = self.rowTapped {
            rowTapped(String(similarMoviesArray[indexPath.row].id))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (Constants.Sizes.sizeOfScreen.width <= 320) ? 100 : 150, height: (Constants.Sizes.sizeOfScreen.height <= 568) ? 100 : 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
}
