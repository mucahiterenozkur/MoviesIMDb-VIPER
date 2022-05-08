//
//  SimilarMoviesCollectionViewCell.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 26.04.2022.
//

import UIKit

final class SimilarMoviesCollectionViewCell: UICollectionViewCell {
    
    private lazy var headerImage : UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.descriptionTextColor
        label.font = Constants.Fonts.descriptionFont
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textDropShadow()
        return label
    }()

    internal func configure(similarMovie: SimilarMoviesResult){
        titleLabel.text = similarMovie.title
        guard let resource = URL(string: Constants.BaseURL.imageBaseURL + (similarMovie.backdropPath  ?? similarMovie.posterPath)) else {return}
        let placeholder = UIImage(named: "header")
        self.headerImage.kf.setImage(with: resource, placeholder: placeholder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension SimilarMoviesCollectionViewCell : SetupView {
    
    internal func buildViewHierarchy() {
        self.addSubviews(headerImage, titleLabel)
    }
    
    internal func setupConstraints() {
        headerImage.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 15, left: 10, bottom: 40, right: 10))
        titleLabel.anchor(top: headerImage.bottomAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 10))
    }
    
    internal func setupAdditionalConfiguration() {}
    
}

