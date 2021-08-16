//
//  UIConstants.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 10.08.2021.
//

import UIKit

enum UIConstants {
    static let movieCellReuseID = "MovieCell"
    
    static let favoritesVCTitle = NSLocalizedString("FavoriteTitle", comment: "")
    static let favoritesVCTabBar = NSLocalizedString("FavoriteTabBar", comment: "")
    
    static let popularVCTitle = NSLocalizedString("PopularTitle", comment: "")
    static let popularVCTabBar = NSLocalizedString("PopularTabBar", comment: "")
    
    static let searchBarPlaceholder = NSLocalizedString("SearchPlaceholder", comment: "")
    
    static let emptyPageTitle = NSLocalizedString("EmptyPageTitle", comment: "")
    static let emptyPageBody = NSLocalizedString("EmptyPageBody", comment: "")
    
    static let movieRate = NSLocalizedString("Votes", comment: "")
    static let movieNotRated = NSLocalizedString("RateNotFound", comment: "")
    
    static let genresTitle = NSLocalizedString("Genres", comment: "")
    static let overviewTitle = NSLocalizedString("Overview", comment: "")
    static let runtimeNotFound = NSLocalizedString("RuntimeNotFound", comment: "")
    
    static let released = NSLocalizedString("Released", comment: "")
    static let inProduction = NSLocalizedString("InProduction", comment: "")
    static let postProduction = NSLocalizedString("PostProduction", comment: "")
    
    static let hourAndMinute = NSLocalizedString("HourAndMinute", comment: "")
    static let hour = NSLocalizedString("Hour", comment: "")
    static let minute = NSLocalizedString("Minute", comment: "")
    
    static let padding: CGFloat = 8
    static let sfSymbolSize: CGFloat = 20
    static let tableViewRowHeight: CGFloat = 115
}
