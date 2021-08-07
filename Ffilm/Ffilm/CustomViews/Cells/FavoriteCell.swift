//
//  FavoriteCell.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 6.08.2021.
//

import UIKit

class FavoriteCell: UITableViewCell {
    static let reuseID = "FavoriteCell"
    let movieImageView = FFImageView(frame: .zero)
    let movieTitleLabel = FFTitleLabel(textAlignment: .left, fontSize: 20)
    
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
        accessoryType = .disclosureIndicator
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            movieImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
//            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            movieImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
//            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
//            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, constant: 25),
            movieImageView.heightAnchor.constraint(equalToConstant: 75),
            movieImageView.widthAnchor.constraint(equalToConstant: 50),
            
            movieTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: padding),
            movieTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}
