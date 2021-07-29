//
//  UINavigationController+Ext.swift
//  A3
//
//  Created by Gökberk Köksoy on 30.07.2021.
//

import UIKit

extension UINavigationController {
    func hideBars() {
        self.navigationBar.isHidden = true
        self.toolbar.isHidden = true
    }
    
    func showBars() {
        self.navigationBar.isHidden = false
        self.toolbar.isHidden = false
    }
}
