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
            return String(format: UIConstants.hourAndMinute, arguments: [hour, minute])
        } else if hour != 0 && minute == 0 {
            return String(format: UIConstants.hour, arguments: [hour])
        } else if hour == 0 && minute != 0 {
            return String(format: UIConstants.minute, arguments: [minute])
        } else {
            return ""
        }
    }
}
