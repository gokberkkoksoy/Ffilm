//
//  Images.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 10.08.2021.
//

import UIKit

enum Images {
    
    static let placeholder = UIImage(named: "notFound")
    
    @available(iOS 13.0, *)
    enum SFSymbols {
        static let calendar = UIImageView(image: UIImage(systemName: "calendar"))
        static let calendarImage = UIImage(systemName: "calendar")
        static let clock =  UIImageView(image: UIImage(systemName: "clock"))
        static let clockImage = UIImage(systemName: "clock")
        static let hourglass = UIImageView(image: UIImage(systemName: "hourglass"))
        static let hourglassImage = UIImage(systemName: "hourglass")
        static let doneHourglassImage = UIImage(systemName: "hourglass.tophalf.fill")
        static let halfFillStar = UIImageView(image: UIImage(systemName: "star.lefthalf.fill"))
        static let halfFillStarImage = UIImage(systemName: "star.lefthalf.fill")
        static let fillStarImage = UIImage(systemName: "star.fill")
        static let emptyStarImage = UIImage(systemName: "star")
    }

    enum SFSymbols12 {
        static let calendar12 = UIImageView(image: UIImage(named: "calendar"))
        static let calendarImage12 = UIImage(named: "calendar")
        static let clock12 = UIImageView(image: UIImage(named: "clock"))
        static let clockImage12 = UIImage(named: "clock")
        static let hourglass12 = UIImageView(image: UIImage(named: "hourglass"))
        static let hourglassImage12 = UIImage(named: "hourglass")
        static let doneHourglassImage12 = UIImage(named: "hourglass.tophalf.filled")
        static let halfFillStar12 = UIImageView(image: UIImage(named: "star.leadinghalf.filled"))
        static let halfFillStarImage12 = UIImage(named: "star.leadinghalf.filled")
        static let fillStarImage12 = UIImage(named: "star.fill")
        static let emptyStarImage12 = UIImage(named: "star")
    }
}
