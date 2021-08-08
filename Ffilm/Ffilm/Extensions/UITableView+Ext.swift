//
//  UIKit.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 7.08.2021.
//

import UIKit

extension UITableView {
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
