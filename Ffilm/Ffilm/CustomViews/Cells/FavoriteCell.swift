//
//  FavoriteCell.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 6.08.2021.
//

import UIKit

class FavoriteCell: UITableViewCell {
    static let reuseID = "FavoriteCell"
    private let movieImageView = FFImageView(frame: .zero)
    private let movieTitleLabel = FFTitleLabel(textAlignment: .left, fontSize: 20)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(movie: MovieDetail) {
        if let poster = movie.posterPath {
            movieImageView.setImage(url: URL(string: NetworkConstants.baseImageURL + poster))
        } else {
            movieImageView.image = UIImage(named: "placeholder.png")
        }
        
        movieTitleLabel.text = movie.title
    }
    
    private func configure() {
        addSubviews(movieImageView, movieTitleLabel)
        movieImageView.layer.cornerRadius = 5
        movieImageView.layer.masksToBounds = true
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            movieImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2 * padding),
            movieImageView.heightAnchor.constraint(equalToConstant: 100),
            movieImageView.widthAnchor.constraint(equalToConstant: 75),
            
            movieTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: padding),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
