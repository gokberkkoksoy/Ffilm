//
//  String+Ext.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 3.08.2021.
//

import UIKit

extension Int {
    func convertToHourAndMinuteString() -> String {
        let hour = self / 60
        let minute = self % 60
        if hour != 0 && minute != 0{
            return "\(hour)h \(minute)m"
        } else if hour != 0 && minute == 0 {
            return "\(hour)h"
        } else if hour == 0 && minute != 0 {
            return "\(minute)h"
        } else {
            return ""
        }
    }
}
