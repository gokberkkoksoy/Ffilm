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
    private var releaseDateSymbol: UIImageView {
        if #available(iOS 13.0, *) {
            return Images.SFSymbols.calendar
        } else {
            return Images.SFSymbols12.calendar12
        }
    }
    private let releaseDateLabel = FFBodyLabel(textAlignment: .left)
    private var runtimeSymbol: UIImageView  {
        if #available(iOS 13.0, *) {
            return Images.SFSymbols.clock
        } else {
            return Images.SFSymbols12.clock12
        }
    }
    private let runtimeLabel = FFBodyLabel(textAlignment: .left)
    private var voteSymbol: UIImageView {
        if #available(iOS 13.0, *) {
            return Images.SFSymbols.halfFillStar
        } else {
            return Images.SFSymbols12.halfFillStar12
        }
    }
    private let voteLabel = FFBodyLabel(textAlignment: .left)
    private var statusSymbol: UIImageView  {
        if #available(iOS 13.0, *) {
            return Images.SFSymbols.hourglass
        } else {
            return Images.SFSymbols12.hourglass12
        }
    }
    private let statusLabel = FFBodyLabel(textAlignment: .left)
    private let movieGenreTitleLabel = FFTitleLabel(textAlignment: .left, fontSize: 18)
    private let movieGenreLabel = FFBodyLabel(textAlignment: .left)
    private let taglineLabel = FFBodyLabel(textAlignment: .left)
    private let overviewTitleLabel = FFTitleLabel(textAlignment: .left, fontSize: 18)
    private let overviewLabel = FFBodyLabel(textAlignment: .left)
    
    var genreStr = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        hideSymbols()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showSymbols() {
        voteSymbol.isHidden = false
        statusSymbol.isHidden = false
        runtimeSymbol.isHidden = false
        releaseDateSymbol.isHidden = false
    }
    
    func hideSymbols() {
        voteSymbol.isHidden = true
        statusSymbol.isHidden = true
        runtimeSymbol.isHidden = true
        releaseDateSymbol.isHidden = true
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
        if let runtime = movie.runtime, runtime != 0 {
            runtimeLabel.text = runtime.convertToHourAndMinuteString()
        } else {
            runtimeLabel.text = UIConstants.runtimeNotFound
        }
        if let vote = movie.voteAverage, let voteCount = movie.voteCount {
            if #available(iOS 13.0, *) {
                voteSymbol.image = vote == 10.0 ? Images.SFSymbols.fillStarImage : Images.SFSymbols.halfFillStarImage
            } else {
                voteSymbol.image = vote == 10.0 ? Images.SFSymbols12.fillStarImage12 : Images.SFSymbols12.halfFillStarImage12
            }
            voteLabel.text = String(format: UIConstants.movieRate, arguments: [vote, voteCount])
            if vote == 0.0 {
                if #available(iOS 13.0, *) {
                    voteSymbol.image = Images.SFSymbols.emptyStarImage
                } else {
                    voteSymbol.image = Images.SFSymbols12.emptyStarImage12
                }
                voteLabel.text = UIConstants.movieNotRated
            }
        }
        
        if let status = movie.status {
            if #available(iOS 13.0, *) {
                statusSymbol.image = status == UIConstants.releasedConst ? Images.SFSymbols.doneHourglassImage : Images.SFSymbols.hourglassImage
            } else {
                statusSymbol.image = status == UIConstants.releasedConst ? Images.SFSymbols12.doneHourglassImage12 : Images.SFSymbols12.hourglassImage12
            }
            switch status {
            case "Released":
                statusLabel.text = UIConstants.released
            case "In Production":
                statusLabel.text = UIConstants.inProduction
            case "Post Production":
                statusLabel.text = UIConstants.postProduction
            default:
                break
            }
        }
        
        movieGenreTitleLabel.text = UIConstants.genresTitle
        movieGenreLabel.text = genreStr
        taglineLabel.text = movie.tagline
        overviewTitleLabel.text = UIConstants.overviewTitle
        overviewLabel.text = movie.overview
        showSymbols()
    }
    
    func configure(){
        addSubviews(scrollView)
        scrollView.addSubviews(contentView)
        contentView.pinToEdges(of: scrollView)
        contentView.addSubviews(backdropImageView, titleLabel,releaseDateSymbol, releaseDateLabel, runtimeSymbol, runtimeLabel, voteSymbol, voteLabel,statusSymbol, statusLabel, movieGenreTitleLabel, movieGenreLabel, taglineLabel, overviewTitleLabel, overviewLabel)
        
        if #available(iOS 13.0, *) {
            releaseDateSymbol.tintColor = .secondaryLabel
            runtimeSymbol.tintColor = .secondaryLabel
            voteSymbol.tintColor = .secondaryLabel
            statusSymbol.tintColor = .secondaryLabel
        } else {
            releaseDateSymbol.tintColor = .systemGray
            runtimeSymbol.tintColor = .systemGray
            voteSymbol.tintColor = .systemGray
            statusSymbol.tintColor = .systemGray
        }
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            backdropImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backdropImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backdropImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backdropImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.6),
            
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
            overviewLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.padding),
            overviewLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
}
