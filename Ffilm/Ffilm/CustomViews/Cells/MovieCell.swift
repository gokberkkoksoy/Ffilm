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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(movieImageView)
        movieImageView.translatesAutoresizingMaskIntoConstraints = false
//        movieImageView.layer.cornerRadius = 5

        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true
        let heightConstant: CGFloat = 100
        
        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, constant: heightConstant),

        ])
    }
    
}
