//
//  MovieDetailVC.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 2.08.2021.
//

import UIKit

protocol ButtonDelegate: AnyObject {
    func buttonTapped()
}

class MovieDetailVC: FFDataLoaderVC, ButtonDelegate {

    var movieID: Int?
    lazy var videoURL = ""
    private let movieDetailView = MovieDetailView(frame: .zero)
    private lazy var unfavButton =  UIBarButtonItem()
    private lazy var favButton =  UIBarButtonItem()
    weak var delegate: UpdatableScreen!

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
        getMovieDetails()
        getVideoURL()
    }

    override func viewWillDisappear(_ animated: Bool) { delegate.updateScreen() }

    func getMovieDetails() {
        if let id = movieID {
            Network.shared.getMovies(id: id) { (response: Result<MovieDetail, FFError>) in
                switch response {
                case.success(let detail):
                    DispatchQueue.main.async { self.movieDetailView.set(to: detail) }
                    self.dismissLoadingView()
                case.failure(let error):
                    self.presentAlertOnMainThread(title: Strings.somethingWentWrong, message: error.localized, buttonTitle: Strings.ok, alertType: .error)
                }
            }
        }
    }
    
    func getVideoURL() {
        if let id = movieID {
            Network.shared.getMovies(id: id, isVideo: true) { (response: Result<Videos, FFError>) in
                switch response  {
                case .success(let result):
                    if let videoCount = result.results?.count {
                        if videoCount == 0 {
                            self.movieDetailView.hideButton()
                        } else {
                            self.movieDetailView.showButton()
                        }
                    }
                    if let results = result.results {
                        for video in results {
                            if video.site == Strings.youtube && video.type == Strings.trailer {
                                if let key = video.key {
                                    self.videoURL = "\(Strings.youtubeURL)\(key)"
                                }
                                break
                            }
                        }
                        if self.videoURL == "" { self.movieDetailView.hideButton() }
                    }
                case .failure(_):
                    self.movieDetailView.hideButton()
                }
            }
        }
    }
    
    func buttonTapped() {
        if videoURL != "" { presentSafariVC(with: URL(string: videoURL)) }
    }

    @objc private func donePressed() { navigationController?.dismiss(animated: true) }

    @objc private func unfavPressed() {
        navigationItem.rightBarButtonItem = favButton
        if let id = movieID {
            PersistenceManager.updateWith(movieID: id, actionType: .remove) { [weak self] error in
                guard let self = self else { return }
                guard let error = error else { return }
                self.presentAlertOnMainThread(title: Strings.somethingWentWrong, message: error.localized, buttonTitle: Strings.ok, alertType: .error)
            }
        }
    }

    @objc private func favPressed() {
        navigationItem.rightBarButtonItem = unfavButton
        if let id = movieID {
            PersistenceManager.updateWith(movieID: id, actionType: .add) { [weak self] error in
                guard let self = self else { return }
                guard let error = error else {
                    self.presentAlertOnMainThread(title: Strings.favSuccessTitle, message: Strings.favSuccess, buttonTitle: Strings.ok, alertType: .notification)
                    return
                }
                self.presentAlertOnMainThread(title: Strings.oops, message: error.localized, buttonTitle: Strings.ok, alertType: .notification)
            }
        }
    }

    private func configureMovieDetailView() {
        view.addSubviews(movieDetailView)
        movieDetailView.buttonDelegate = self
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
        NSLayoutConstraint.activate([
            movieDetailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieDetailView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            movieDetailView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieDetailView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
