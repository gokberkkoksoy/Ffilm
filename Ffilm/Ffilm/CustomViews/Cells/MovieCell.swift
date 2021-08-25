//
//  MovieCell.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 31.07.2021.
//

import UIKit

enum ImageDisplay {
    case show, hide
}

class MovieCell: UICollectionViewCell {
    static let reuseID = UIConstants.movieCellReuseID
    
    let movieImageView = FFImageView(frame: .zero)
    let favoriteBackgroundView = UIView(frame: .zero)
    let favoriteImageView = UIImageView(frame: .zero)
    let titleBackgroundView = UIView(frame: .zero)
    let titleLabel = FFTitleLabel(textAlignment: .center, fontSize: UIConstants.movieCellTitleSize)
    var cellId: Int = .zero
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setFavoriteState(mode: ImageDisplay) {
        favoriteImageView.isHidden = mode == .hide ? true : false
        favoriteBackgroundView.isHidden = mode == .hide ? true : false
    }
    
    func toggleState(){
        favoriteBackgroundView.isHidden.toggle()
        favoriteImageView.isHidden.toggle()
    }

    func setCell(with movie: Movie) {
        if let posterPath = movie.posterPath {
            movieImageView.setImage(url: URL(string: NetworkConstants.baseImageURL + posterPath))
            titleBackgroundView.isHidden = true
            titleLabel.isHidden = true
        } else {
            movieImageView.image = Images.placeholder
            titleBackgroundView.isHidden = false
            titleLabel.isHidden = false
        }
        
        if Bundle.main.preferredLocalizations.first == "tr"  {
            titleBackgroundView.isHidden = false
            titleLabel.isHidden = false
        }

        if let title = movie.title { titleLabel.text = title }
        if let id = movie.id { cellId = id }
    }

    private func configure() {
        addSubviews(movieImageView, favoriteBackgroundView, favoriteImageView, titleBackgroundView, titleLabel)
        titleLabel.pinToEdges(of: titleBackgroundView)

        movieImageView.contentMode = .scaleAspectFill
        movieImageView.image = Images.placeholder
        let heightConstant: CGFloat = DeviceTypes.isiPhone8Standard ? 60 : 100

        favoriteBackgroundView.backgroundColor = Colors.blackBackground
        favoriteBackgroundView.layer.masksToBounds = true
        favoriteBackgroundView.layer.cornerRadius = UIConstants.imageViewCornerRadius

        if #available(iOS 13.0, *) {
            favoriteImageView.image = Images.SFSymbols.movieCellFavoriteImage
            favoriteImageView.tintColor = Colors.favoriteSymbolColor
        } else {
            favoriteImageView.image = Images.SFSymbols12.movieCellFavoriteImage12
        }

        titleBackgroundView.backgroundColor = Colors.movieCellTitleBackground
        titleLabel.textColor = .white

        NSLayoutConstraint.activate([
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            movieImageView.heightAnchor.constraint(equalTo: movieImageView.widthAnchor, constant: heightConstant),

            favoriteBackgroundView.topAnchor.constraint(equalTo: topAnchor),
            favoriteBackgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            favoriteBackgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            favoriteBackgroundView.bottomAnchor.constraint(equalTo: favoriteImageView.bottomAnchor),

            favoriteImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            favoriteImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -UIConstants.padding),
            favoriteImageView.heightAnchor.constraint(equalToConstant: UIConstants.movieCellFavoriteImageSize),
            favoriteImageView.widthAnchor.constraint(equalTo: favoriteImageView.heightAnchor),

            titleBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleBackgroundView.heightAnchor.constraint(equalToConstant: UIConstants.movieCellFavoriteImageBackgroundSize)

        ])
    }

}
