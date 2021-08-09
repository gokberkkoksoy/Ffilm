//
//  MovieDetailView.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 3.08.2021.
//

import UIKit
import Kingfisher

class MovieDetailView: UIView {

    private let backdropImageView = FFImageView(frame: .zero)
    private let titleLabel = FFTitleLabel(textAlignment: .left, fontSize: 20)
    private let releaseDateSymbol = UIImageView(image: UIImage(systemName: "calendar"))
    private let releaseDateLabel = FFBodyLabel(textAlignment: .left)
    private let runtimeSymbol = UIImageView(image: UIImage(systemName: "clock"))
    private let runtimeLabel = FFBodyLabel(textAlignment: .left)
//    private let movieInfoLabel = FFBodyLabel(textAlignment: .left)
    private let movieGenreLabel = FFBodyLabel(textAlignment: .left)
    private let taglineLabel = FFBodyLabel(textAlignment: .left)
    private let overviewTitleLabel = FFTitleLabel(textAlignment: .left, fontSize: 18)
    private let overviewLabel = FFBodyLabel(textAlignment: .left)
    
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
        releaseDateLabel.text = movie.releaseDate?.convertToDate()
        runtimeLabel.text = movie.runtime?.convertToHourAndMinuteString()
        
        movieGenreLabel.text = genreStr
        taglineLabel.text = movie.tagline
        overviewTitleLabel.text = "Overview"
        overviewLabel.text = movie.overview
    }
    
    func configure() {
        addSubviews(backdropImageView, titleLabel,releaseDateSymbol, releaseDateLabel, runtimeSymbol, runtimeLabel, movieGenreLabel, taglineLabel, overviewTitleLabel, overviewLabel)
        
        releaseDateSymbol.tintColor = .secondaryLabel
        runtimeSymbol.tintColor = .secondaryLabel
        NSLayoutConstraint.activate([
            backdropImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            backdropImageView.heightAnchor.constraint(equalToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            releaseDateSymbol.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            releaseDateSymbol.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            releaseDateSymbol.heightAnchor.constraint(equalToConstant: 20),
            releaseDateSymbol.widthAnchor.constraint(equalTo: releaseDateSymbol.heightAnchor),
            
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            releaseDateLabel.leadingAnchor.constraint(equalTo: releaseDateSymbol.trailingAnchor, constant: 8),
            releaseDateLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            runtimeSymbol.topAnchor.constraint(equalTo: releaseDateSymbol.bottomAnchor, constant: 8),
            runtimeSymbol.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
            runtimeSymbol.heightAnchor.constraint(equalToConstant: 20),
            runtimeSymbol.widthAnchor.constraint(equalTo: releaseDateSymbol.heightAnchor),
            
            runtimeLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 8),
            runtimeLabel.leadingAnchor.constraint(equalTo: runtimeSymbol.trailingAnchor, constant: 8),
            runtimeLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            
//            movieInfoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
//            movieInfoLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 8),
//            movieInfoLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -8),
            
            movieGenreLabel.topAnchor.constraint(equalTo: runtimeLabel.bottomAnchor, constant: 8),
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
