//
//  MovieCell.swift
//  MoviesIMDb
//
//  Created by Mücahit Eren Özkur on 26.04.2022.
//

import UIKit

final class MovieCell: UITableViewCell {
    
    private let cellId = "cellId"
    private var movieID = [Int]()
    
    private lazy var movieImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 8
        iv.layer.masksToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.mainTextColor
        label.font = Constants.Fonts.headerFont
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private lazy var shortDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.textColor = Constants.Colors.descriptionTextColor
        label.font = Constants.Fonts.defaultFont
        return label
    }()

    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Colors.descriptionTextColor
        label.font = Constants.Fonts.dateFont
        return label
    }()
    
    internal func configure(movieItem: UpcomingResult){
        headerLabel.text = movieItem.title
        shortDescriptionLabel.text = movieItem.overview
        dateLabel.text = movieItem.releaseDate
        movieID.append(movieItem.id)
        guard let resource = URL(string: Constants.BaseURL.imageBaseURL + (movieItem.backdropPath ?? movieItem.posterPath ?? "noImage")) else {return}
        let placeholder = UIImage(named: "header")
        self.movieImage.kf.setImage(with: resource, placeholder: placeholder)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: cellId)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


extension MovieCell : SetupView {
    
    internal func buildViewHierarchy() {
        self.addSubviews(movieImage, headerLabel, shortDescriptionLabel, dateLabel)
    }
    
    internal func setupConstraints() {
        movieImage.anchor(top: self.topAnchor, leading: self.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 15, left: 20, bottom: 0, right: 0), size: .init(width: 100, height: 100))
        
        headerLabel.anchor(top: movieImage.topAnchor, leading: movieImage.trailingAnchor, bottom: nil, trailing: self.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 0, right: 20))
        
        shortDescriptionLabel.anchor(top: nil, leading: movieImage.trailingAnchor, bottom: movieImage.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 10, left: 10, bottom: 15, right: 50))
        
        dateLabel.anchor(top: nil, leading: nil, bottom: self.bottomAnchor, trailing: self.trailingAnchor, padding: .init(top: 0, left: 0, bottom: 10, right: 20))

    }
    
    internal func setupAdditionalConfiguration() {}
    
}
