//
//  MoviesVC.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 31.07.2021.
//

import UIKit

protocol UpdatableScreen: AnyObject {
    func updateScreen()
}

class MoviesVC: FFDataLoaderVC {
    
    private var collectionView: UICollectionView!
    private let emptyView = EmptyStateView(frame: .zero)

    @available(iOS 13.0, *)
    private lazy var dataSource = UICollectionViewDiffableDataSource<Section, Movie>()
    
    private var movies = [Movie]()
    private var searchedMovies = [Movie]()
    private var page = 1
    private var searchPage = 1
    private var totalPage: Int = .zero
    private var searchTotalPage: Int = .zero
    private var hasMorePages = true
    private var isNotLoadingMovies = true
    private var isSearching = false
    private var searchFilter = String()
    private var favorites = [Int]()
    private lazy var selectedMovieIndexPath = IndexPath()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //  if you do not write this next line, when you click to the search bar and switch between tabbar items WITHOUT SEARCHING ANY MOVIE(CURSOR IS ACTIVE)
        //  view controller will disappear. on ios13+ versions this problem does not occur. only on ios 12.x
        definesPresentationContext = true
        setSearchControllerPlaceholder(with: Strings.searchBarPlaceholder)
        configureCollectionView()
        emptyView.frame = view.bounds
        if #available(iOS 13.0, *) { configureDataSource() }
        NotificationCenter.default.addObserver(self, selector: #selector(self.cellFavoriteStateChanged), name: Strings.Notifications.favoriteStateChanged, object: nil)
        getMovies(of: NetworkConstants.basePopularURL, from: page)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        getFavorites()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    //MARK: - CONFIGURATION METHODS
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.getThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.keyboardDismissMode  = .onDrag
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
            self.getFavorites()
            cell.setFavoriteState(mode: self.favorites.contains(cell.cellId) ? .show : .hide)
            return cell
        }
    }
    
    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                self.favorites = favorites
            case.failure(let error):
                self.presentAlertOnMainThread(title: Strings.somethingWentWrong, message: error.localized, buttonTitle: Strings.ok, alertType: .error)
            }
        }
    }
    //MARK: - PERSISTENCE METHODS
    override func updateScreen() {
        getFavorites()
    }
    
    @objc func cellFavoriteStateChanged() {
        getFavorites()
        guard let cell = collectionView.cellForItem(at: selectedMovieIndexPath) as? MovieCell else { return }
        cell.toggleState()
    }
    
    private func getMovies(of category: String, from page: Int) {
        isNotLoadingMovies = false
        Network.shared.getMovies(from: category, in: page) { [weak self] (response: Result<MovieCategory,FFError>) in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                guard let pageNum = result.totalPages, let results = result.results else { return }
                self.totalPage = pageNum
                self.updateUI(with: results) 
            case .failure(let error):
                self.presentIndicator(with: error.localized)
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
//MARK: - SEARCH BAR
    override func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty, isNotLoadingMovies else {
            searchedMovies.removeAll()
            isSearching = false
            searchFilter.removeAll()
            updateData(on: movies)
            DispatchQueue.main.async { self.emptyView.removeFromSuperview() }
            return
        }
        isSearching = true
        searchPage = 1
        searchFilter = filter
        Network.shared.getMovies(from: NetworkConstants.movieSearchURL, with: searchFilter.replaceSpecialCharacters(), in: searchPage) { [weak self] (response: Result<MovieCategory, FFError>) in
            guard let self = self else { return }
            switch response {
            case .success(let result):
                self.searchedMovies.removeAll()
                guard let pageNum = result.totalPages, let results = result.results else { return }
                DispatchQueue.main.async {
                    if results.isEmpty {
                        self.emptyView.setLabels(header: Strings.emptySearchTitle, body: Strings.emptySearchBody)
                        self.view.addSubview(self.emptyView)
                    } else {
                        self.emptyView.removeFromSuperview()
                    }
                }
                self.searchTotalPage = pageNum
                self.updateUI(with: results)
            case.failure(_):
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.emptyView.setLabels(header: Strings.offline, body: Strings.checkConnection)
                    self.view.addSubview(self.emptyView)
                }
            }
        }
    }
    
    deinit {
      NotificationCenter.default.removeObserver(self, name: Strings.Notifications.favoriteStateChanged, object: nil)
    }
}
//MARK: - COLLECTION VIEW DELEGATE-DATASOURCE
extension MoviesVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? searchedMovies.count : movies.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCell.reuseID, for: indexPath) as! MovieCell
        cell.setCell(with: isSearching ? searchedMovies[indexPath.item] : movies[indexPath.item])
        getFavorites()
        cell.setFavoriteState(mode: self.favorites.contains(cell.cellId) ? .show : .hide)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedMovieIndexPath = indexPath
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
//MARK: - PAGINATION
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard hasMorePages, isNotLoadingMovies else { return }
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height

        if offsetY > contentHeight - height {
            if isSearching {
                if searchPage < searchTotalPage {
                    searchPage += 1
                    Network.shared.getMovies(from: NetworkConstants.movieSearchURL, with: searchFilter.replaceSpecialCharacters(), in: searchPage) { [weak self] (response: Result<MovieCategory, FFError>) in
                        guard let self = self else { return }
                        switch response {
                        case .success(let result):
                            guard let pageNum = result.totalPages, let results = result.results else { return }
                            self.searchTotalPage = pageNum
                            self.updateUI(with: results)
                        case.failure(let error):
                            self.presentIndicator(with: error.localized)
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
