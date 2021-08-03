//
//  String+Ext.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 3.08.2021.
//

import UIKit

extension Int {
    func convertToHourAndMinuteString() -> String {
        return "\(self / 60)h \(self % 60)m"
    }
}
