//
//  UIView+Ext.swift
//  Assignment1
//
//  Created by Gökberk Köksoy on 28.07.2021.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views { addSubview(view) }
    }
}
