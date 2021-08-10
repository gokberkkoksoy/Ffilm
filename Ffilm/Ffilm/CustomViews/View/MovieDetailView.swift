//
//  MovieDetailView.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 3.08.2021.
//

import UIKit
import Kingfisher

class MovieDetailView: UIView {
    
    let scrollView = UIScrollView()
    let contentView = UIView(frame: .zero)

    private let backdropImageView = FFImageView(frame: .zero)
    private let titleLabel = FFTitleLabel(textAlignment: .left, fontSize: 22)
    private let releaseDateSymbol = UIImageView(image: UIImage(systemName: "calendar"))
    private let releaseDateLabel = FFBodyLabel(textAlignment: .left)
    private let runtimeSymbol = UIImageView(image: UIImage(systemName: "clock"))
    private let runtimeLabel = FFBodyLabel(textAlignment: .left)
    private var voteSymbol = UIImageView(image: UIImage(systemName: "star.lefthalf.fill"))
    private let voteLabel = FFBodyLabel(textAlignment: .left)
    private var statusSymbol = UIImageView(image: UIImage(systemName: "hourglass"))
    private let statusLabel = FFBodyLabel(textAlignment: .left)
    private let movieGenreTitleLabel = FFTitleLabel(textAlignment: .left, fontSize: 18)
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
        if let backdropPath = movie.backdropPath, let url = URL(string: NetworkConstants.backdropURL + backdropPath) {
            backdropImageView.setImage(url: url)
            backdropImageView.contentMode = .scaleAspectFill
        } else {
            backdropImageView.image = UIImage(named: "notFound")
        }
        if let releaseDate = movie.releaseDate , let title = movie.title {
            titleLabel.text = title + " (\(releaseDate.getDateYear()))"
        }
        if let genres = movie.genres {
            for (index,genre) in genres.enumerated() {
                if let name = genre.name { genreStr += index < genres.count - 1 ? "\(name), " : "\(name)" }
            }
        }
        releaseDateLabel.text = movie.releaseDate?.convertToDate()
        runtimeLabel.text = movie.runtime?.convertToHourAndMinuteString()
        if let vote = movie.voteAverage {
            voteSymbol.image = vote == 10.0 ? UIImage(systemName: "star.fill") : UIImage(systemName: "star.lefthalf.fill")
            voteLabel.text = "\(vote)/10 (\(movie.voteCount!) votes)"
            if vote == 0.0 {
                voteSymbol.image = UIImage(systemName: "star")
                voteLabel.text = "This movie has not been rated yet."
            }
        }
        
        if let status = movie.status {
            if status == "Released" {
                statusSymbol.image = UIImage(systemName: "hourglass.tophalf.fill")
            }
            statusLabel.text = status
        }
        
        movieGenreTitleLabel.text = "Genres"
        movieGenreLabel.text = genreStr
        taglineLabel.text = movie.tagline
        overviewTitleLabel.text = "Overview"
        overviewLabel.text = movie.overview
        
    }
    
    func configure(){
        addSubviews(scrollView)
        scrollView.pinToEdges(of: self)
        scrollView.addSubviews(contentView)
        contentView.pinToEdges(of: scrollView)
        contentView.addSubviews(backdropImageView, titleLabel,releaseDateSymbol, releaseDateLabel, runtimeSymbol, runtimeLabel, voteSymbol, voteLabel,statusSymbol, statusLabel, movieGenreTitleLabel, movieGenreLabel, taglineLabel, overviewTitleLabel, overviewLabel)
        
        releaseDateSymbol.tintColor = .secondaryLabel
        runtimeSymbol.tintColor = .secondaryLabel
        voteSymbol.tintColor = .secondaryLabel
        statusSymbol.tintColor = .secondaryLabel
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            
            backdropImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backdropImageView.heightAnchor.constraint(equalToConstant: 250),
            
            titleLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            releaseDateSymbol.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            releaseDateSymbol.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            releaseDateSymbol.heightAnchor.constraint(equalToConstant: 20),
            releaseDateSymbol.widthAnchor.constraint(equalTo: releaseDateSymbol.heightAnchor),
            
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            releaseDateLabel.leadingAnchor.constraint(equalTo: releaseDateSymbol.trailingAnchor, constant: 8),
            releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            runtimeSymbol.topAnchor.constraint(equalTo: releaseDateSymbol.bottomAnchor, constant: 8),
            runtimeSymbol.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            runtimeSymbol.heightAnchor.constraint(equalToConstant: 20),
            runtimeSymbol.widthAnchor.constraint(equalTo: releaseDateSymbol.heightAnchor),
            
            runtimeLabel.topAnchor.constraint(equalTo: releaseDateSymbol.bottomAnchor, constant: 8),
            runtimeLabel.leadingAnchor.constraint(equalTo: runtimeSymbol.trailingAnchor, constant: 8),
            runtimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            voteSymbol.topAnchor.constraint(equalTo: runtimeSymbol.bottomAnchor, constant: 8),
            voteSymbol.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            voteSymbol.heightAnchor.constraint(equalToConstant: 20),
            voteSymbol.widthAnchor.constraint(equalTo: voteSymbol.heightAnchor),
            
            voteLabel.topAnchor.constraint(equalTo: runtimeSymbol.bottomAnchor, constant: 8),
            voteLabel.leadingAnchor.constraint(equalTo: voteSymbol.trailingAnchor, constant: 8),
            voteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            statusSymbol.topAnchor.constraint(equalTo: voteSymbol.bottomAnchor, constant: 8),
            statusSymbol.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            statusSymbol.heightAnchor.constraint(equalToConstant: 20),
            statusSymbol.widthAnchor.constraint(equalTo: statusSymbol.heightAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: voteSymbol.bottomAnchor, constant: 8),
            statusLabel.leadingAnchor.constraint(equalTo: voteSymbol.trailingAnchor, constant: 8),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            movieGenreTitleLabel.topAnchor.constraint(equalTo: statusSymbol.bottomAnchor, constant: 24),
            movieGenreTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            movieGenreTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            movieGenreLabel.topAnchor.constraint(equalTo: movieGenreTitleLabel.bottomAnchor, constant: 8),
            movieGenreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            movieGenreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            taglineLabel.topAnchor.constraint(equalTo: movieGenreLabel.bottomAnchor,constant: 24),
            taglineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            taglineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            overviewTitleLabel.topAnchor.constraint(equalTo: taglineLabel.bottomAnchor, constant: 24),
            overviewTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            overviewTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            
            overviewLabel.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor, constant: 8),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
    }

}
