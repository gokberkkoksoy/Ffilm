//
//  FavoritesVC.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 31.07.2021.
//

import UIKit

class FavoritesVC: FFDataLoaderVC, UpdatableScreen {
    
    private let tableView = UITableView()
    private var favorites = [Int]()
    private let emptyView = EmptyStateView(header: Strings.emptyPageTitle, body: Strings.emptyPageBody)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Strings.clearAll, style: .done, target: self, action: #selector(clearPressed))
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavorites()
        navigationItem.rightBarButtonItem?.isEnabled = favorites.isEmpty ? false : true
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc private func clearPressed(){
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
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.rowHeight = UIConstants.tableViewRowHeight
        tableView.delegate = self
        tableView.dataSource = self
        tableView.removeExcessCells()
        
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    private func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)
            case.failure(let error):
                self.presentAlertOnMainThread(title: Strings.somethingWentWrong, message: error.localized, buttonTitle: Strings.ok, alertType: .error)
            }
        }
    }
    
    func updateScreen() {
        getFavorites()
        navigationItem.rightBarButtonItem?.isEnabled = favorites.isEmpty ? false : true
    }
    
    private func updateUI(with favorites: [Int]) {
        if favorites.isEmpty {
            self.favorites = favorites
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.addSubview(self.emptyView)
            }
        } else {
            self.favorites = favorites
            emptyView.removeFromSuperview()
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
    
    func removeFromFavorites(at index: Int) {
        PersistenceManager.updateWith(movieID: favorites[index], actionType: .remove) { [weak self] error in
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

}

extension FavoritesVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID, for: indexPath) as! FavoriteCell
        Network.shared.getMovieDetail(of: favorites[indexPath.row]) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let movie):
                DispatchQueue.main.async {
                    cell.set(movie: movie)
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: Strings.somethingWentWrong, message: error.localized, buttonTitle: Strings.ok, alertType: .error)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let movie = favorites[indexPath.row]
        let destVC = MovieDetailVC()
        destVC.movieID = movie
        destVC.delegate = self
        let navController = UINavigationController(rootViewController: destVC)
        present(navController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        removeFromFavorites(at: indexPath.row)
    }
    
    
}
