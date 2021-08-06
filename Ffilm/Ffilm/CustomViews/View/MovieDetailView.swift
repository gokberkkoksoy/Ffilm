//
//  MovieDetailView.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 3.08.2021.
//

import UIKit
import Kingfisher

class MovieDetailView: UIView {

    let backdropImageView = FFImageView(frame: .zero)
    let titleLabel = FFTitleLabel(textAlignment: .left, fontSize: 20)
    let movieInfoLabel = FFBodyLabel(textAlignment: .left)
    let movieGenreLabel = FFBodyLabel(textAlignment: .left)
    let taglineLabel = FFBodyLabel(textAlignment: .left)
    let overviewTitleLabel = FFTitleLabel(textAlignment: .left, fontSize: 18)
    let overviewLabel = FFBodyLabel(textAlignment: .left)
    
    var genreStr = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(to movie: MovieDetail) {
        backdropImageView.setImage(url: URL(string: NetworkConstants.backdropURL + (movie.backdropPath ?? "")))
        if let releaseDate = movie.releaseDate , let title = movie.title {
            titleLabel.text = title + " (\(releaseDate.getDateYear()))"
        }
        if let genres = movie.genres {
            for (index,genre) in genres.enumerated() {
                if let name = genre.name {
                    genreStr += index < genres.count - 1 ? "\(name), " : "\(name)"
                }
            }
        }
        
        movieInfoLabel.text = (movie.releaseDate?.convertToDate() ?? "") + " • " + (movie.runtime?.convertToHourAndMinuteString() ?? "")
        movieGenreLabel.text = genreStr
        taglineLabel.text = movie.tagline
        overviewTitleLabel.text = "Overview"
        overviewLabel.text = movie.overview
    }
    
    func configure() {
        addSubviews(backdropImageView, titleLabel, movieInfoLabel, movieGenreLabel, taglineLabel, overviewTitleLabel, overviewLabel)
        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            backdropImageView.heightAnchor.constraint(equalToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            movieInfoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            movieInfoLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            movieInfoLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            movieGenreLabel.topAnchor.constraint(equalTo: movieInfoLabel.bottomAnchor, constant: 8),
            movieGenreLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            movieGenreLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            taglineLabel.topAnchor.constraint(equalTo: movieGenreLabel.bottomAnchor,constant: 16),
            taglineLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            taglineLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            overviewTitleLabel.topAnchor.constraint(equalTo: taglineLabel.bottomAnchor, constant: 16),
            overviewTitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            overviewTitleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            overviewLabel.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor, constant: 8),
            overviewLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            overviewLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8)
        ])

    }

    
    
    

}
