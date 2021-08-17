//
//  FavoritesVC.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 31.07.2021.
//

import UIKit

class FavoritesVC: FFDataLoaderVC, UpdatableScreen {
    func updateScreen() {
        getFavorites()
    }
    

    private let tableView = UITableView()
    private var favorites = [Int]()
    private let emptyView = EmptyStateView(header: UIConstants.emptyPageTitle, body: UIConstants.emptyPageBody)

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(clearPressed))
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavorites()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    @objc private func clearPressed(){
        if favorites.isEmpty { return }
        for i in (0..<favorites.count).reversed() {
            PersistenceManager.updateWith(movieID: favorites[i], actionType: .remove) { [weak self] error in
                guard let self = self else { return }
                guard let error = error else {
                    self.favorites.remove(at: i)
                    self.tableView.deleteRows(at: [IndexPath(row: i, section: .zero)], with: .left)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        self.updateUI(with: self.favorites)
                    }
                    return
                }
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
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
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
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
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
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
        
        PersistenceManager.updateWith(movieID: favorites[indexPath.row], actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else {
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.updateUI(with: self.favorites)
                }
                return
            }
            self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
        }
    }
    
    
}
