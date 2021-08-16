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
    
    static let emptySearchTitle = NSLocalizedString("EmptySearchTitle", comment: "")
    static let emptySearchBody = NSLocalizedString("EmptySearchBody", comment: "")
    
    static let movieRate = NSLocalizedString("Votes", comment: "")
    static let movieNotRated = NSLocalizedString("RateNotFound", comment: "")
    
    static let genresTitle = NSLocalizedString("Genres", comment: "")
    static let overviewTitle = NSLocalizedString("Overview", comment: "")
    static let runtimeNotFound = NSLocalizedString("RuntimeNotFound", comment: "")
    
    static let released = NSLocalizedString("Released", comment: "")
    static let releasedConst = "Released"
    
    static let inProduction = NSLocalizedString("InProduction", comment: "")
    static let postProduction = NSLocalizedString("PostProduction", comment: "")
    
    static let hourAndMinute = NSLocalizedString("HourAndMinute", comment: "")
    static let hour = NSLocalizedString("Hour", comment: "")
    static let minute = NSLocalizedString("Minute", comment: "")
    
    static let padding: CGFloat = 8
    static let sfSymbolSize: CGFloat = 20
    static let tableViewRowHeight: CGFloat = 115
}

enum ScreenSize {
    static let width        = UIScreen.main.bounds.size.width
    static let height       = UIScreen.main.bounds.size.height
    static let maxLength    = max(ScreenSize.width, ScreenSize.height)
    static let minLength    = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceTypes {
    static let idiom                    = UIDevice.current.userInterfaceIdiom
    static let nativeScale              = UIScreen.main.nativeScale
    static let scale                    = UIScreen.main.scale

    static let isiPhoneSE               = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard        = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhone8PlusStandard    = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed      = idiom == .phone && ScreenSize.maxLength == 736.0 && nativeScale < scale
    static let isiPhoneX                = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr       = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                   = idiom == .pad && ScreenSize.maxLength >= 1024.0

    static func isiPhoneXAspectRatio() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}
