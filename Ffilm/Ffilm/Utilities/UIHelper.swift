//
//  UIHelper.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 1.08.2021.
//

import UIKit

enum UIHelper {
    static func getThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - minimumItemSpacing
        let itemWidth = availableWidth / 2

        let heightConstant: CGFloat = DeviceTypes.isiPhone8Standard ? 60 : 100

        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + heightConstant)

        return flowLayout
    }
}
