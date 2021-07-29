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
        let availableWidth = width - (Constants.padding * 2) - Constants.spaceBetweenItems
        let itemWidth = availableWidth / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: Constants.padding, left: Constants.padding, bottom: Constants.padding, right: Constants.padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + Constants.height)
        
        self.collectionViewLayout = flowLayout
    }
}
