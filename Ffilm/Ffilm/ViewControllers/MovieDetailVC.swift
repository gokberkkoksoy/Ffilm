//
//  MovieDetailVC.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 2.08.2021.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    var movieID: Int?
    private let movieDetailView = MovieDetailView(frame: .zero)
    private var unfavButton: UIBarButtonItem!
    private var favButton: UIBarButtonItem!
    var delegate: UpdatableScreen!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        favButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(favPressed))
        unfavButton = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(unfavPressed))
        configureMovieDetailView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
//        showLoadingView()
        getMovieDetails()
//        delegate = self
//        dismissLoadingView()

    }
    
    func getMovieDetails() {
        if let id = movieID {
            Network.shared.getMovieDetail(of: id) { response in
                switch response {
                case.success(let detail):
                    DispatchQueue.main.async { self.movieDetailView.set(to: detail) }
                case.failure(let error):
                    print(error)
                }
            }
        }
    }
    
    @objc internal func donePressed() {
        delegate.updateScreen()
        navigationController?.dismiss(animated: true)
    }
    
    @objc private func unfavPressed() {
        navigationItem.leftBarButtonItem = favButton
        if let id = movieID {
            PersistenceManager.updateWith(movieID: id, actionType: .remove) { [weak self] error in
                guard let self = self else { return }
                guard let error = error else { return }
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    @objc private func favPressed() {
        navigationItem.leftBarButtonItem = unfavButton
        if let id = movieID {
            PersistenceManager.updateWith(movieID: id, actionType: .add) { [weak self] error in
                guard let self = self else { return }
                guard let error = error else {
                    self.presentAlertOnMainThread(title: "Yayy!", message: "You've successfully favorited this movie.", buttonTitle: "OK")
                    return
                }
                self.presentAlertOnMainThread(title: "Oops", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    private func configureMovieDetailView(){
        view.addSubview(movieDetailView)
        if let id = movieID {
            PersistenceManager.retrieveFavorites { result in
                switch result {
                case .success(let favorites):
                    self.navigationItem.leftBarButtonItem = favorites.contains(id) ? self.unfavButton : self.favButton
                case .failure(_):
                    break
                }
            }
        }
        movieDetailView.pinToEdges(of: view)
    }

}

extension MovieDetailVC: UpdatableScreen {
    func updateScreen() {
        print("lol")
    }
    
}
