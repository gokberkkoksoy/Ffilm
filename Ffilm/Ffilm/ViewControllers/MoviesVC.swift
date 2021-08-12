//
//  MoviesVC.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 31.07.2021.
//

import UIKit
import Kingfisher

protocol UpdatableScreen: AnyObject {
    func updateScreen()
}


class MoviesVC: FFDataLoaderVC, UpdatableScreen {
    
    private enum Section { case main }
    private var collectionView: UICollectionView!
    
    @available(iOS 13.0, *)
    private lazy var dataSource = UICollectionViewDiffableDataSource<Section, Movie>()
    
    private var movies = [Movie]()
    private var searchedMovies = [Movie]()
    private var page = 1
    private var searchPage = 1
    private var totalPage = 0
    private var searchTotalPage = 0
    private var hasMorePages = true
    private var isNotLoadingMovies = true
    private var isSearching = false
    private var searchFilter = ""
    private var cells = [MovieCell]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
//  if you do not write this next line, when you click to the search bar and switch between tabbar items WITHOUT SEARCHING ANY MOVIE(CURSOR IS ACTIVE)
//  view controller will disappear. on ios13+ versions this problem does not occur. only on ios 12.x
        definesPresentationContext = true
        configureSearchController()
        configureCollectionView()
        if #available(iOS 13.0, *) { configureDataSource() }
        getMovies(of: NetworkConstants.basePopularURL, from: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        configureCellState()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = UIConstants.searchBarPlaceholder
        searchController.obscuresBackgroundDuringPresentation = false // false -> does not faint the screen
        if #available(iOS 13.0, *){} else { navigationController?.navigationBar.isHidden = false }
        navigationItem.searchController = searchController
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.getThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        if #available(iOS 13.0, *) { collectionView.backgroundColor = .systemBackground } else { collectionView.backgroundColor = .white }
        collectionView.register(MovieCell.self, forCellWithReuseIdentifier: MovieCell.reuseID)
    }
    
    @available(iOS 13.0, *)
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, movie in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
            cell.setCell(with: movie)
            self.configureCellState()
            self.cells.append(cell)
            return cell
        }
    }
    
    func configureCellState() {
        for cell in cells {
            PersistenceManager.retrieveFavorites { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success(let favorites):
//                    DispatchQueue.main.async {
                        cell.setFavoriteState(mode: favorites.contains(cell.cellId) ? .show : .hide)
//                    }
                case.failure(let error):
                    self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
                }
            }
        }
    }
    
    func updateScreen() {
        configureCellState()
    }
    
    private func getMovies(of category: String, from page: Int) {
        isNotLoadingMovies = false
        Network.shared.getMovies(from: category, in: page) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                guard let pageNum = result.totalPages, let results = result.results else { return }
                self.totalPage = pageNum
                self.updateUI(with: results) 
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Oops...", message: error.rawValue, buttonTitle: "OK")
            }
            self.isNotLoadingMovies = true
        }
        
    }
    
    private func updateUI(with movies: [Movie]) {
        hasMorePages = page < totalPage ? true : false
        if isSearching {
            self.searchedMovies.append(contentsOf: movies)
            updateData(on: self.searchedMovies)
        } else {
            self.movies.append(contentsOf: movies)
            updateData(on: self.movies)
        }
    }
    
    private func updateData(on movies: [Movie]) {
        if #available(iOS 13.0, *) {
            var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
            snapshot.appendSections([.main])
            snapshot.appendItems(movies)
            DispatchQueue.main.async { self.dataSource.apply(snapshot, animatingDifferences: true) }
        } else {
            DispatchQueue.main.async { self.collectionView.reloadData() }
        }
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
        Network.shared.getMovies(from: NetworkConstants.movieSearchURL, with: searchFilter.replaceSpecialCharacters(), in: searchPage) { [weak self] response in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                self.searchedMovies.removeAll()
                guard let pageNum = result.totalPages, let results = result.results else { return }
                //                if results.isEmpty {
                //                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                //                        self.showEmptyFollowerListView(header: "Sorry, we don't have what you are looking for.", message: "Maybe try to look for something else?", in: self.view)
                //                    }
                //                } else {
                //                    DispatchQueue.main.async { self.hideEmptyView() }
                //                }
                print(results)
                self.searchTotalPage = pageNum
                self.updateUI(with: results)
            case.failure(let error):
                self.presentAlertOnMainThread(title: "Oops.", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
}

extension MoviesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? searchedMovies.count: movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
        cell.setCell(with: isSearching ? searchedMovies[indexPath.item] : movies[indexPath.item])
        self.configureCellState()
        self.cells.append(cell)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var movie = Movie()
        if #available(iOS 13.0, *) {
            guard let selectedMovie = dataSource.itemIdentifier(for: indexPath) else { return }
            movie = selectedMovie
        } else {
            let selectedMovie = isSearching ? searchedMovies[indexPath.item] : movies[indexPath.item]
            movie = selectedMovie
        }
        guard let id = movie.id else { return }
        let destVC = MovieDetailVC()
        destVC.movieID = id
        destVC.delegate = self
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
                    Network.shared.getMovies(from: NetworkConstants.movieSearchURL, with: searchFilter.replaceSpecialCharacters(), in: searchPage) { [weak self] response in
                        guard let self = self else { return }
                        switch response {
                        case .success(let result):
                            guard let pageNum = result.totalPages, let results = result.results else { return }
                            print(results)
                            self.searchTotalPage = pageNum
                            self.updateUI(with: results)
                        case.failure(let error):
                            self.presentAlertOnMainThread(title: "Oops...", message: error.rawValue, buttonTitle: "OK")
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

