//
//  MovieDetailVC.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 2.08.2021.
//

import UIKit

class MovieDetailVC: FFDataLoaderVC {
    
    var movieID: Int?
    private let movieDetailView = MovieDetailView(frame: .zero)
    private lazy var unfavButton =  UIBarButtonItem()
    private lazy var favButton =  UIBarButtonItem()
    var delegate: UpdatableScreen!

    override func viewDidLoad() {
        super.viewDidLoad()
        showLoadingView(in: view)
        if #available(iOS 13.0, *) { view.backgroundColor = .systemBackground } else {  view.backgroundColor = .white }
        if #available(iOS 13.0, *) {
            favButton = UIBarButtonItem(image: Images.SFSymbols.emptyStarImage, style: .plain, target: self, action: #selector(favPressed))
        } else {
            favButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(favPressed))
        }
        if #available(iOS 13.0, *) {
            unfavButton = UIBarButtonItem(image: Images.SFSymbols.fillStarImage, style: .plain, target: self, action: #selector(unfavPressed))
        } else {
            unfavButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(unfavPressed))
        }
        configureMovieDetailView()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
//        showLoadingView()
        getMovieDetails()
//        dismissLoadingView()

    }
    
    override func viewWillDisappear(_ animated: Bool) { delegate.updateScreen() }
    
    func getMovieDetails() {
        if let id = movieID {
            Network.shared.getMovieDetail(of: id) { response in
                switch response {
                case.success(let detail):
                    DispatchQueue.main.async {
                        self.movieDetailView.set(to: detail)
                        self.dismissLoadingView()
                    }
                case.failure(let error):
                    print(error)
                }
            }
        }
    }
    
    @objc internal func donePressed() { navigationController?.dismiss(animated: true) }
    
    @objc private func unfavPressed() {
        navigationItem.rightBarButtonItem = favButton
        if let id = movieID {
            PersistenceManager.updateWith(movieID: id, actionType: .remove) { [weak self] error in
                guard let self = self else { return }
                guard let error = error else { return }
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    @objc private func favPressed() {
        navigationItem.rightBarButtonItem = unfavButton
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
        view.addSubviews(movieDetailView)
        if let id = movieID {
            PersistenceManager.retrieveFavorites { result in
                switch result {
                case .success(let favorites):
                    self.navigationItem.rightBarButtonItem = favorites.contains(id) ? self.unfavButton : self.favButton
                case .failure(_):
                    break
                }
            }
        }
//        movieDetailView.pinToEdges(of: view)
        NSLayoutConstraint.activate([
            movieDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movieDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])

    }

}
