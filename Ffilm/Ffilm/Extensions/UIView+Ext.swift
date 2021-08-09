//
//  UIView+Ext.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 3.08.2021.
//

import UIKit

extension UIView {
    
    static let loadingViewTag = 1938123987
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
    
    func showLoading(style: UIActivityIndicatorView.Style = .medium) {
        
        var loading = viewWithTag(UIImageView.loadingViewTag) as? UIActivityIndicatorView
        if loading == nil {
            loading = UIActivityIndicatorView(style: style)
        }
        
        loading?.translatesAutoresizingMaskIntoConstraints = false
        loading!.startAnimating()
        loading!.hidesWhenStopped = true
        loading?.tag = UIView.loadingViewTag
        addSubview(loading!)
        loading?.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        loading?.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    func stopLoading() {
        let loading = viewWithTag(UIView.loadingViewTag) as? UIActivityIndicatorView
        loading?.stopAnimating()
        loading?.removeFromSuperview()
    }
    
    
}
