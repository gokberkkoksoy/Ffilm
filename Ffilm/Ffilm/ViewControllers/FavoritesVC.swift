//
//  FavoritesVC.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 31.07.2021.
//

import UIKit

class FavoritesVC: FFDataLoaderVC {

    private let tableView = UITableView()
    private var favorites = [MovieDetail]()
    private var favStorage = [MovieDetail]()
    private var filteredFavorites = [MovieDetail]()
    private let emptyView = EmptyStateView(header: Strings.emptyPageTitle, body: Strings.emptyPageBody)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Strings.clearAll, style: .done, target: self, action: #selector(clearPressed))
        configureTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        getFavorites()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    @objc private func clearPressed() {
        let ac = UIAlertController(title: Strings.sure, message: Strings.cannotUndo, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: Strings.cancel, style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: Strings.delete, style: .destructive) { action in
            for i in (0..<self.favorites.count).reversed() {
                self.removeFromFavorites(at: i)
            }
        })
        present(ac, animated: true)
    }

    private func configureViewController() {
        if #available(iOS 13.0, *) { view.backgroundColor = .systemBackground }
        navigationController?.navigationBar.prefersLargeTitles = true
        emptyView.frame = view.bounds
    }

    private func updateUI(with favorites: [MovieDetail]) {
            if favorites.isEmpty {
                self.favorites = favorites
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.view.addSubview(self.emptyView)
                }
            } else {
                self.favorites = favorites
                DispatchQueue.main.async {
                    self.emptyView.removeFromSuperview()
                    self.tableView.reloadData()
                    self.view.bringSubviewToFront(self.tableView)
                }
            }
    }

    private func configureTableView() {
        view.addSubviews(tableView)
        tableView.rowHeight = UIConstants.tableViewRowHeight
        tableView.keyboardDismissMode = .onDrag
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()

        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let storedFavorites):
                DispatchQueue.main.async { self.navigationItem.rightBarButtonItem?.isEnabled = storedFavorites.isEmpty ? false : true }
                self.favorites.removeAll()
                self.favStorage.removeAll()
                storedFavorites.forEach {
                    Network.shared.getMovies(id: $0) { [weak self] (result: Result<MovieDetail, FFError>) in
                        guard let self = self else { return }
                        switch result {
                        case .success(let movieDetail):
                            self.favorites.append(movieDetail)
                            self.favStorage.append(movieDetail)
                            self.updateUI(with: self.favorites)
                        case .failure(let error):
                            self.presentAlertOnMainThread(title: Strings.somethingWentWrong, message: error.localized, buttonTitle: Strings.ok, alertType: .error)
                        }
                    }
                }
                self.updateUI(with: self.favorites)
            case.failure(let error):
                self.presentAlertOnMainThread(title: Strings.somethingWentWrong, message: error.localized, buttonTitle: Strings.ok, alertType: .error)
            }
        }
    }

    override func updateScreen() {
        getFavorites()
    }

    func removeFromFavorites(at index: Int) {
        PersistenceManager.updateWith(movieID: favorites[index].id ?? .zero , actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.favorites.remove(at: index)
                self.tableView.deleteRows(at: [IndexPath(row: index, section: .zero)], with: .left)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.navigationItem.rightBarButtonItem?.isEnabled = self.favorites.isEmpty ? false : true
                    self.updateUI(with: self.favorites)
                }
                return
            }
            self.presentAlertOnMainThread(title: Strings.somethingWentWrong, message: error.localized, buttonTitle: Strings.ok, alertType: .error)
        }
    }
    
    override func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text?.lowercased(), !filter.isEmpty else {
            filteredFavorites.removeAll()
            updateUI(with: favStorage)
            DispatchQueue.main.async { self.emptyView.removeFromSuperview() }
            return
        }
        filteredFavorites = favStorage.filter {
            if let movieTitle = $0.title?.lowercased() { return movieTitle.contains(filter) }
            return false
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { self.updateUI(with: self.filteredFavorites) }
        if filteredFavorites.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
//                change messages here
                self.view.addSubview(self.emptyView)
            }
        } else {
            self.view.bringSubviewToFront(self.tableView)
        }
    }

}

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        DispatchQueue.main.async { cell.set(movie: self.favorites[indexPath.row]) }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = favorites[indexPath.row]
        let destVC = MovieDetailVC()
        destVC.movieID = movie.id ?? .zero
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        self.removeFromFavorites(at: indexPath.row)
    }

}
