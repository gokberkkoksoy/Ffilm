//
//  FFDataLoaderVC.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 6.08.2021.
//

import UIKit

class FFDataLoaderVC: UIViewController {
    
    var containerView: UIView!

    func showLoadingView(in view: UIView) {
        containerView = UIView(frame: .zero)
        view.addSubviews(containerView)
        if #available(iOS 13.0, *) {
            containerView.backgroundColor = .systemBackground
        } else {
            containerView.backgroundColor = .white
        }
        containerView.alpha = 0 // initially invisible
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
            activityIndicator.style = .large
        } else {
            activityIndicator.style = .gray
        }
        containerView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.pinToEdges(of: view)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    func showEmptyFollowerListView(header: String, message: String, in view: UIView) {
        let emptyStateView = EmptyFollowerListView(header: header, body: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }

}
