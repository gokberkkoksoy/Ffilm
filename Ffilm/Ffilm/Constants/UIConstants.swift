//
//  UIConstants.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 10.08.2021.
//

import UIKit

enum UIConstants {
    static let movieCellReuseID = "MovieCell"

    static let padding: CGFloat = 8
    static let sfSymbolSize: CGFloat = 20
    static let tableViewRowHeight: CGFloat = 115
    static let imageViewCornerRadius: CGFloat = 5
    static let videoButtonCornerRadius: CGFloat = 40
    static let videoButtonHeight: CGFloat = 80
    static let sfSymbolHeight: CGFloat = 20
    static let backdropImageHeightFactor: CGFloat = 0.6
    static let movieDetailTitleFontSize: CGFloat = 22
    static let movieDetailSubtitleFontSize: CGFloat = 18
    static let emptyStateTitleSize: CGFloat = 30
    static let movieCellTitleSize: CGFloat = 15
    static let movieCellFavoriteImageSize: CGFloat = 30
    static let movieCellFavoriteImageBackgroundSize: CGFloat = 35
    static let favoriteCellTitleLabelSize: CGFloat = 30
    static let favoriteCellImageWidth: CGFloat = 75
    static let favoriteCellImageHeight: CGFloat = 100
    
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
