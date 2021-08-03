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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        configureMovieDetailView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed))
        if let id = movieID {
            Network.shared.getMovieDetail(of: id) { response in
                switch response {
                case.success(let detail):
                    print(detail)
                    DispatchQueue.main.async {
                        self.movieDetailView.set(to: detail)
                    }
                case.failure(let error):
                    print(error)
                }
            }
        }

    }
    
    @objc private func donePressed() { navigationController?.dismiss(animated: true) }
    
    private func configureMovieDetailView(){
        view.addSubview(movieDetailView)
        movieDetailView.pinToEdges(of: view)
    }

}
