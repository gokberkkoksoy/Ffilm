//
//  MovieCell.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 31.07.2021.
//

import UIKit

enum ImageDisplay {
    case show, hide
}

class MovieCell: UICollectionViewCell {
    static let reuseID = UIConstants.movieCellReuseID
    
    let movieImageView = FFImageView(frame: .zero)
    let favoriteBackgroundView = UIView(frame: .zero)
    let favoriteImageView = UIImageView(frame: .zero)
    let titleBackgroundView = UIView(frame: .zero)
    let titleLabel = FFTitleLabel(textAlignment: .center, fontSize: 14)
    var cellId = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFavorite(mode: ImageDisplay){
        favoriteImageView.isHidden = mode == .hide ? true : false
        favoriteBackgroundView.isHidden = mode == .hide ? true : false
    }
    
    private func configure() {
        addSubviews(movieImageView,favoriteBackgroundView, favoriteImageView, titleBackgroundView, titleLabel)
        titleLabel.pinToEdges(of: titleBackgroundView)
        
        movieImageView.layer.cornerRadius = 5
        movieImageView.layer.masksToBounds = true
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.image = Images.placeholder
        let heightConstant: CGFloat = 130
        
        favoriteBackgroundView.alpha = 0.33
        favoriteBackgroundView.backgroundColor = .black
        favoriteBackgroundView.layer.masksToBounds = true
        favoriteBackgroundView.layer.cornerRadius = 5
        
        favoriteImageView.image = UIImage(systemName: "star.circle")
        favoriteImageView.tintColor = UIColor(red: 0.56, green: 0.81, blue: 0.63, alpha: 1.00)
        
        titleBackgroundView.alpha = 0.5
        titleBackgroundView.backgroundColor = .black
        
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, constant: heightConstant),
            
            favoriteBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            favoriteBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            favoriteBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            favoriteBackgroundView.bottomAnchor.constraint(equalTo: favoriteImageView.bottomAnchor),

            favoriteImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: UIConstants.padding),
            favoriteImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.padding),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 30),
            favoriteImageView.widthAnchor.constraint(equalTo: favoriteImageView.heightAnchor),
            
            titleBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleBackgroundView.heightAnchor.constraint(equalToConstant: 35),
            
            
        ])
    }
    
}
