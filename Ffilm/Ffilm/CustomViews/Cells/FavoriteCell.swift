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
    private var movieDateSymbol = UIImageView(frame: .zero)
    private let movieDateLabel = FFBodyLabel(textAlignment: .left)
    private var movieRuntimeSymbol  = UIImageView(frame: .zero)
    private let movieRuntimeLabel = FFBodyLabel(textAlignment: .left)
    
    
    
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
            movieImageView.image = Images.placeholder
        }
        
        movieTitleLabel.text = movie.title
        movieDateLabel.text = movie.releaseDate?.convertToDate()
        if #available(iOS 13.0, *)   {
            movieDateSymbol.image = Images.SFSymbols.calendarImage
            movieDateSymbol.tintColor = .secondaryLabel
            movieRuntimeSymbol.image = Images.SFSymbols.clockImage
            movieRuntimeSymbol.tintColor = .secondaryLabel
        } else {
            movieDateSymbol.image = Images.SFSymbols12.calendarImage12
            movieDateSymbol.tintColor = .systemGray
            movieRuntimeSymbol.image = Images.SFSymbols12.clockImage12
            movieRuntimeSymbol.tintColor = .systemGray
        }
        if let runtime = movie.runtime, runtime != 0 {
            movieRuntimeLabel.text = runtime.convertToHourAndMinuteString()
        } else {
            movieRuntimeLabel.text = UIConstants.runtimeNotFound
        }
    }
    
    private func configure() {
        addSubviews(movieImageView, movieTitleLabel, movieDateSymbol, movieDateLabel, movieRuntimeSymbol, movieRuntimeLabel)
        accessoryType = .disclosureIndicator
        
        NSLayoutConstraint.activate([
            movieImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2 * UIConstants.padding),
            movieImageView.heightAnchor.constraint(equalToConstant: 100),
            movieImageView.widthAnchor.constraint(equalToConstant: 75),
            
            movieTitleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -25),
            movieTitleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: UIConstants.padding),
            movieTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.padding),
            movieTitleLabel.heightAnchor.constraint(equalToConstant: 30),
            
            movieDateSymbol.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: UIConstants.padding),
            movieDateSymbol.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: UIConstants.padding),
            movieDateSymbol.widthAnchor.constraint(equalToConstant: UIConstants.sfSymbolSize),
            movieDateSymbol.heightAnchor.constraint(equalToConstant: UIConstants.sfSymbolSize),
            
            movieDateLabel.topAnchor.constraint(equalTo: movieTitleLabel.bottomAnchor, constant: UIConstants.padding),
            movieDateLabel.leadingAnchor.constraint(equalTo: movieDateSymbol.trailingAnchor, constant: UIConstants.padding),
            movieDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.padding),
            movieDateLabel.heightAnchor.constraint(equalToConstant: UIConstants.sfSymbolSize),
            
            movieRuntimeSymbol.topAnchor.constraint(equalTo: movieDateLabel.bottomAnchor, constant: UIConstants.padding),
            movieRuntimeSymbol.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: UIConstants.padding),
            movieRuntimeSymbol.widthAnchor.constraint(equalToConstant: UIConstants.sfSymbolSize),
            movieRuntimeSymbol.heightAnchor.constraint(equalToConstant: UIConstants.sfSymbolSize),
            
            movieRuntimeLabel.topAnchor.constraint(equalTo: movieDateLabel.bottomAnchor, constant: UIConstants.padding),
            movieRuntimeLabel.leadingAnchor.constraint(equalTo: movieRuntimeSymbol.trailingAnchor, constant: UIConstants.padding),
            movieRuntimeLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.padding),
            movieRuntimeLabel.heightAnchor.constraint(equalToConstant: UIConstants.sfSymbolSize),
            
            
        ])
    }
    
}
