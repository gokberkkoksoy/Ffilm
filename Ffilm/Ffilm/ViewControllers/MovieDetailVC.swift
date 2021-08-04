//
//  MovieDetailVC.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 2.08.2021.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    var movieID: Int?
    let movieDetailView = MovieDetailView(frame: .zero)
    var unfavButton: UIBarButtonItem!
    var favButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureMovieDetailView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        favButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: self, action: #selector(favPressed))
        unfavButton = UIBarButtonItem(image: UIImage(systemName: "star.fill"), style: .plain, target: self, action: #selector(unfavPressed))
        navigationItem.leftBarButtonItem = favButton
        getMovieDetails()

    }
    
    func getMovieDetails() {
        if let id = movieID {
            Network.shared.getMovieDetail(of: id) { response in
                switch response {
                case.success(let detail):
                    print(detail)
                    DispatchQueue.main.async { self.movieDetailView.set(to: detail) }
                case.failure(let error):
                    print(error)
                }
            }
        }
    }
    
    @objc private func donePressed() { navigationController?.dismiss(animated: true) }
    
    @objc private func unfavPressed() {
        navigationItem.leftBarButtonItem = favButton
    }
    
    @objc private func favPressed() {
        navigationItem.leftBarButtonItem = unfavButton
    }
    
    private func configureMovieDetailView(){
        view.addSubview(movieDetailView)
        movieDetailView.pinToEdges(of: view)
    }

}
