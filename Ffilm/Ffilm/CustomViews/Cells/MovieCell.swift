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
    let titleLabel = FFTitleLabel(textAlignment: .center, fontSize: 15)
    var cellId = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setFavoriteState(mode: ImageDisplay) {
        favoriteImageView.isHidden = mode == .hide ? true : false
        favoriteBackgroundView.isHidden = mode == .hide ? true : false
    }
    
    func setCell(with movie: Movie) {
        if let posterPath = movie.posterPath, let url = URL(string: NetworkConstants.baseImageURL + posterPath) {
            movieImageView.setImage(url: url)
            titleBackgroundView.isHidden = true
            titleLabel.isHidden = true
        } else {
            movieImageView.image = Images.placeholder
            titleBackgroundView.isHidden = false
            titleLabel.isHidden = false
        }
        
        if let title = movie.title { titleLabel.text = title }
        if let id = movie.id { cellId = id }
    }
    
    private func configure() {
        addSubviews(movieImageView,favoriteBackgroundView, favoriteImageView, titleBackgroundView, titleLabel)
        titleLabel.pinToEdges(of: titleBackgroundView)
        
        movieImageView.contentMode = .scaleAspectFill
        movieImageView.image = Images.placeholder
        let heightConstant: CGFloat = 130
        
        favoriteBackgroundView.alpha = 0.33
        favoriteBackgroundView.backgroundColor = .black
        favoriteBackgroundView.layer.masksToBounds = true
        favoriteBackgroundView.layer.cornerRadius = 5
        
        if #available(iOS 13.0, *) {
            favoriteImageView.image = UIImage(systemName: "star.circle")
        } else {
            favoriteImageView.image = UIImage(named: "heart.circle")
        }
        favoriteImageView.tintColor = UIColor(red: 0.56, green: 0.81, blue: 0.63, alpha: 1.00)
        
        titleBackgroundView.alpha = 0.5
        titleBackgroundView.backgroundColor = .black
        titleLabel.textColor = .white
        
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, constant: heightConstant),
            
            favoriteBackgroundView.topAnchor.constraint(equalTo: self.topAnchor),
            favoriteBackgroundView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            favoriteBackgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            favoriteBackgroundView.bottomAnchor.constraint(equalTo: favoriteImageView.bottomAnchor),

            favoriteImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            favoriteImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.padding),
            favoriteImageView.heightAnchor.constraint(equalToConstant: 30),
            favoriteImageView.widthAnchor.constraint(equalTo: favoriteImageView.heightAnchor),
            
            titleBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleBackgroundView.heightAnchor.constraint(equalToConstant: 35)
            
            
        ])
    }
    
}
