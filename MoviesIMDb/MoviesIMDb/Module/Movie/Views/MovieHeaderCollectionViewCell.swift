//
//  MovieHeaderCell.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 26.04.2022.
//

import UIKit
import Kingfisher

final class MovieHeaderCell: UICollectionViewCell {
    
    private lazy var headerImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()

    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.headerTextColor
        label.font = Constants.Fonts.headerFont
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textDropShadow()
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal func headerCellConfigure(movieItem: NowPlayingResult){
        guard let resource = URL(string: Constants.BaseURL.imageBaseURL + (movieItem.backdropPath ?? movieItem.posterPath)) else {return}
        let placeholder = UIImage(named: "header")
        self.headerImage.kf.setImage(with: resource, placeholder: placeholder)
        self.headerLabel.text = movieItem.title
    }

}

extension MovieHeaderCell : SetupView {
    
    internal func buildViewHierarchy() {
        self.addSubviews(headerImage)
        headerImage.addSubviews(headerLabel)
    }
    
    internal func setupConstraints() {
        headerImage.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        headerLabel.anchor(top: nil, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    internal func setupAdditionalConfiguration() {}
    
}

