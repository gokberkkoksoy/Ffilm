//
//  Constants.swift
//  A3
//
//  Created by Gökberk Köksoy on 29.07.2021.
//

import UIKit

enum Constants {
    static let endpoint = "https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?l=English%20Premier%20League"
    static let cellReuseID = "TeamCell"
    static let errorMessage = "Unable to generate cell"
    static let https = "https://"
    
    static let dismiss = "Dismiss"
    static let visit = "Visit Webpage"
    static let backgroundColor = UIColor(red: 0.20, green: 0.00, blue: 0.23, alpha: 1.00)
    
    static let padding: CGFloat = 16
    static let height: CGFloat = 48
    static let spaceBetweenItems: CGFloat = 16
}
