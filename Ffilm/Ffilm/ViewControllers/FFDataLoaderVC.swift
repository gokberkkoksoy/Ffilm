//
//  FFDataLoaderVC.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 6.08.2021.
//

import UIKit

class FFDataLoaderVC: UIViewController, UISearchResultsUpdating, UpdatableScreen {
    var containerView: UIView!
    let searchController = UISearchController(searchResultsController: nil)
    
    enum Section { case main }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false // false -> does not faint the screen
        if #available(iOS 13.0, *) {} else { navigationController?.navigationBar.isHidden = false }
        navigationItem.searchController = searchController
    }
    
    func setSearchControllerPlaceholder(with text: String) {
        searchController.searchBar.placeholder = text
    }
    
    func removeSearchController() {
        navigationItem.searchController = nil
    }

    func showLoadingView(in view: UIView) {
        containerView = UIView(frame: .zero)
        view.addSubviews(containerView)
        if #available(iOS 13.0, *) {
            containerView.backgroundColor = .systemBackground
        } else {
            containerView.backgroundColor = .white
        }
        containerView.alpha = .zero // initially invisible
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
        let emptyStateView = EmptyStateView(header: header, body: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
    func updateScreen() {}
    func updateSearchResults(for searchController: UISearchController) {}

}
