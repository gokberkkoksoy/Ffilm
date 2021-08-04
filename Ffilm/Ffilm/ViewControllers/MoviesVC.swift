//
//  MoviesVC.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 31.07.2021.
//

import UIKit
import Kingfisher


class MoviesVC: UIViewController {
    #warning("PRESENT ERROR MESSAGES")
    #warning("search bar does not show when scrolling")
    
    enum Section { case main }
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Movie>!
    var mockArray = [Movie]()
    var filteredMovies = [Movie]()
    var page = 1
    var totalPage = 0
    var hasMorePages = true
    var isNotLoadingMovies = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
        configureSearchController()
        configureCollectionView()
        configureDataSource()
        getMovies(of: NetworkConstants.basePopularURL, from: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = UIConstants.searchBarPlaceholder
        searchController.obscuresBackgroundDuringPresentation = false // false -> does not faint the screen
        navigationItem.searchController = searchController
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.getThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView, cellProvider: { collectionView, indexPath, movie in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
            if let posterPath = movie.posterPath, let url = URL(string: NetworkConstants.baseImageURL + posterPath) {
                cell.movieImageView.setImage(url: url)
            }
            return cell
        })
    }
    
    func getMovies(of category: String, from page: Int) {
        isNotLoadingMovies = false
        Network.shared.getMovies(from: category, in: page) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                guard let pageNum = result.totalPages, let results = result.results else { return }
                self.totalPage = pageNum
                self.updateUI(with: results)
            case .failure(let error):
                print(error.localizedDescription)
            }
            self.isNotLoadingMovies = true
        }
        
    }
    
    func updateUI(with movies: [Movie]) {
        hasMorePages = page < totalPage ? true : false
        self.mockArray.append(contentsOf: movies)
        #warning("Error message here if empty array returns")
        updateData(on: self.mockArray)
    }
    
    func updateData(on movies: [Movie]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
    }
    
}

extension MoviesVC: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            updateData(on: mockArray)
            return
        }
        filteredMovies = mockArray.filter { ($0.title?.lowercased().contains(filter.lowercased()))! }
        updateData(on: filteredMovies)
    }
}

extension MoviesVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let selectedMovie = dataSource.itemIdentifier(for: indexPath), let id = selectedMovie.id else { return }
        let destVC = MovieDetailVC()
        destVC.movieID = id
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard hasMorePages, isNotLoadingMovies else { return }
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height && page < totalPage {
            page += 1
            getMovies(of: NetworkConstants.basePopularURL, from: page)
        }
    }
}

