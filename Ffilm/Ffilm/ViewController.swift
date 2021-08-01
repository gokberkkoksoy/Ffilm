//
//  ViewController.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 31.07.2021.
//

import UIKit
import Kingfisher


class MoviesVC: UIViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
    
    var collectionView: UICollectionView! // cannot initialize here because view is not initialized yet
    var mockArray = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        configureSearchController()
        configureCollectionView()
        Network.shared.getNames { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let array):
                self.mockArray = array
                DispatchQueue.main.async { self.collectionView.reloadData() }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: getThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        // will get the items with diffable data source
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
    }
    
    func getThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - minimumItemSpacing
        let itemWidth = availableWidth / 2
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 80)
        
        return flowLayout
    }
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false // true -> faints the screen a little bit
        navigationItem.searchController = searchController
    }
    
}

extension MoviesVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
        cell.movieLabel.text = mockArray[indexPath.item].title
        let url = URL(string: "https://image.tmdb.org/t/p/w500/" + mockArray[indexPath.item].poster_path!)
        cell.movieImageView.kf.setImage(with: url!)
        return cell
        
    }
    
    
}


