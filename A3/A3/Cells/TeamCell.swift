//
//  TeamCell.swift
//  A3
//
//  Created by Gökberk Köksoy on 29.07.2021.
//

import UIKit

class TeamCell: UICollectionViewCell {
    @IBOutlet var teamNameLabel: UILabel! {
        didSet {
            teamNameLabel.textAlignment = .center
            teamNameLabel.textColor = .white
        }
    }
    @IBOutlet var teamBadgeImageView: UIImageView!
    
}
