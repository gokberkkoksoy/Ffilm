//
//  MovieCell.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 31.07.2021.
//

import UIKit

class MovieCell: UICollectionViewCell {
    static let reuseID = UIConstants.movieCellReuseID
    
    let movieImageView = UIImageView(frame: .zero)
    let movieLabel = UILabel(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(movieImageView)
        addSubview(movieLabel)
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
        movieLabel.translatesAutoresizingMaskIntoConstraints = false
        movieLabel.textAlignment = .center
        movieLabel.numberOfLines = 3
        movieLabel.lineBreakMode = .byTruncatingTail
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, constant: 24),
            
            movieLabel.topAnchor.constraint(equalTo: movieImageView.bottomAnchor, constant: 2 * padding),
            movieLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
            movieLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding)
        ])
    }
    
}
