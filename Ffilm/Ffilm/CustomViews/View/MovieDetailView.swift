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
    private let releaseDateSymbol = Images.SFSymbols.calendar
    private let releaseDateLabel = FFBodyLabel(textAlignment: .left)
    private let runtimeSymbol = Images.SFSymbols.clock
    private let runtimeLabel = FFBodyLabel(textAlignment: .left)
    private var voteSymbol = Images.SFSymbols.halfFillStar
    private let voteLabel = FFBodyLabel(textAlignment: .left)
    private let statusSymbol = Images.SFSymbols.hourglass
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
            backdropImageView.image = Images.placeholder
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
            voteSymbol.image = vote == 10.0 ? Images.SFSymbols.fillStarImage : Images.SFSymbols.halfFillStarImage
            voteLabel.text = "\(vote)/10 (\(movie.voteCount!) votes)"
            if vote == 0.0 {
                voteSymbol.image = Images.SFSymbols.emptyStarImage
                voteLabel.text = UIConstants.movieNotRated
            }
        }
        
        if let status = movie.status {
            statusSymbol.image = status == UIConstants.releasedStatus ? Images.SFSymbols.doneHourglassImage : Images.SFSymbols.hourglassImage
            statusLabel.text = status
        }
        
        movieGenreTitleLabel.text = UIConstants.genresTitle
        movieGenreLabel.text = genreStr
        taglineLabel.text = movie.tagline
        overviewTitleLabel.text = UIConstants.overviewTitle
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
            
            titleLabel.topAnchor.constraint(equalTo: backdropImageView.bottomAnchor, constant: 2 * UIConstants.padding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.padding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.padding),
            
            releaseDateSymbol.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIConstants.padding),
            releaseDateSymbol.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.padding),
            releaseDateSymbol.heightAnchor.constraint(equalToConstant: 20),
            releaseDateSymbol.widthAnchor.constraint(equalTo: releaseDateSymbol.heightAnchor),
            
            releaseDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: UIConstants.padding),
            releaseDateLabel.leadingAnchor.constraint(equalTo: releaseDateSymbol.trailingAnchor, constant: UIConstants.padding),
            releaseDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.padding),
            
            runtimeSymbol.topAnchor.constraint(equalTo: releaseDateSymbol.bottomAnchor, constant: UIConstants.padding),
            runtimeSymbol.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.padding),
            runtimeSymbol.heightAnchor.constraint(equalToConstant: 20),
            runtimeSymbol.widthAnchor.constraint(equalTo: releaseDateSymbol.heightAnchor),
            
            runtimeLabel.topAnchor.constraint(equalTo: releaseDateSymbol.bottomAnchor, constant: UIConstants.padding),
            runtimeLabel.leadingAnchor.constraint(equalTo: runtimeSymbol.trailingAnchor, constant: UIConstants.padding),
            runtimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.padding),
            
            voteSymbol.topAnchor.constraint(equalTo: runtimeSymbol.bottomAnchor, constant: UIConstants.padding),
            voteSymbol.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.padding),
            voteSymbol.heightAnchor.constraint(equalToConstant: 20),
            voteSymbol.widthAnchor.constraint(equalTo: voteSymbol.heightAnchor),
            
            voteLabel.topAnchor.constraint(equalTo: runtimeSymbol.bottomAnchor, constant: UIConstants.padding),
            voteLabel.leadingAnchor.constraint(equalTo: voteSymbol.trailingAnchor, constant: UIConstants.padding),
            voteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.padding),
            
            statusSymbol.topAnchor.constraint(equalTo: voteSymbol.bottomAnchor, constant: UIConstants.padding),
            statusSymbol.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.padding),
            statusSymbol.heightAnchor.constraint(equalToConstant: 20),
            statusSymbol.widthAnchor.constraint(equalTo: statusSymbol.heightAnchor),
            
            statusLabel.topAnchor.constraint(equalTo: voteSymbol.bottomAnchor, constant: UIConstants.padding),
            statusLabel.leadingAnchor.constraint(equalTo: voteSymbol.trailingAnchor, constant: UIConstants.padding),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.padding),
            
            movieGenreTitleLabel.topAnchor.constraint(equalTo: statusSymbol.bottomAnchor, constant: 3 * UIConstants.padding),
            movieGenreTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.padding),
            movieGenreTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.padding),
            
            movieGenreLabel.topAnchor.constraint(equalTo: movieGenreTitleLabel.bottomAnchor, constant: UIConstants.padding),
            movieGenreLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.padding),
            movieGenreLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.padding),
            
            taglineLabel.topAnchor.constraint(equalTo: movieGenreLabel.bottomAnchor,constant: 3 * UIConstants.padding),
            taglineLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.padding),
            taglineLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.padding),
            
            overviewTitleLabel.topAnchor.constraint(equalTo: taglineLabel.bottomAnchor, constant: 3 * UIConstants.padding),
            overviewTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.padding),
            overviewTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.padding),
            
            overviewLabel.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor, constant: UIConstants.padding),
            overviewLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: UIConstants.padding),
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.padding)
        ])
    }

}
