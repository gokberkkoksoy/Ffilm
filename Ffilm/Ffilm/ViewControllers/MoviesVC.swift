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
    var movies = [Movie]()
    var searchedMovies = [Movie]()
    var page = 1
    var searchPage = 1
    var totalPage = 0
    var searchTotalPage = 0
    var hasMorePages = true
    var isNotLoadingMovies = true
    var isSearching = false
    var searchFilter = ""
    
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
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, movie in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
            if let posterPath = movie.posterPath, let url = URL(string: NetworkConstants.baseImageURL + posterPath) {
                cell.movieImageView.setImage(url: url)
            } else {
                cell.movieImageView.image = UIImage(named: "placeholder.png")
            }
            return cell
        }
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
        self.movies.append(contentsOf: movies)
        #warning("Error message here if empty array returns")
        updateData(on: self.movies)
    }
    
    func updateSearchUI(with movies: [Movie]){
        hasMorePages = page < totalPage ? true : false
        self.searchedMovies.append(contentsOf: movies)
        updateData(on: self.searchedMovies)
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
        guard let filter = searchController.searchBar.text, !filter.isEmpty , isNotLoadingMovies else {
            searchedMovies.removeAll()
            isSearching = false
            searchFilter = ""
            updateData(on: movies)
            return
        }
        isSearching = true
        searchPage = 1
        searchFilter = filter
        Network.shared.getMovies(from: NetworkConstants.movieSearchURL, with: "&query=\(searchFilter.replaceSpecialCharacters())", in: searchPage) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                self.searchedMovies.removeAll()
                guard let pageNum = result.totalPages, let results = result.results else { return }
                print(results)
                self.searchTotalPage = pageNum
                self.updateSearchUI(with: results)
            case.failure(let error):
                print(error)
            }
        }
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

        if offsetY > contentHeight - height {
            if isSearching {
                if searchPage < searchTotalPage {
                    searchPage += 1
                    Network.shared.getMovies(from: NetworkConstants.movieSearchURL, with: "&query=\(searchFilter.replaceSpecialCharacters())", in: searchPage) { [weak self] response in
                        guard let self = self else { return }
                        switch response {
                        case .success(let result):
                            guard let pageNum = result.totalPages, let results = result.results else { return }
                            print(results)
                            self.searchTotalPage = pageNum
                            self.updateSearchUI(with: results)
                        case.failure(let error):
                            print(error)
                        }
                    }
                }
            } else {
                if page < totalPage {
                    page += 1
                    getMovies(of: NetworkConstants.basePopularURL, from: page)
                }
            }
        }
    }
}

