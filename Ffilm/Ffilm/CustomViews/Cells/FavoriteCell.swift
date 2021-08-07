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
    let overviewLabel = FFBodyLabel(textAlignment: .left)
    
    
}
