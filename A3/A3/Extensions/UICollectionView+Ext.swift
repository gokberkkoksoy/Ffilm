//
//  UICollectionView+Ext.swift
//  A3
//
//  Created by Gökberk Köksoy on 29.07.2021.
//

import UIKit

extension UICollectionView {
    func setDoubleItemLayout(in view: UIView) {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - minimumItemSpacing
        let itemWidth = availableWidth / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        
        self.collectionViewLayout = flowLayout
    }
}
