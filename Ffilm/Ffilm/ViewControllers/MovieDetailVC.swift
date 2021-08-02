//
//  MovieDetailVC.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 2.08.2021.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    var movieID: Int?
    let backdropImageView = UIImageView(frame: .zero)
    let titleLabel = UILabel(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        if let id = movieID {
            Network.shared.getMovieDetail(of: id) { response in
                switch response {
                case.success(let detail):
                    print(detail)
                case.failure(let error):
                    print(error)
                }
            }
        }

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
