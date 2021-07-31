//
//  FFTabBarController.swift
//  Ffilm
//
//  Created by Gökberk Köksoy on 31.07.2021.
//

import UIKit

class FFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .orange
        viewControllers = [createMoviesNC(), createFavoritesNC()]
        UITabBar.appearance().barStyle = .default //  .black gives a darker tone
    }
    
    func createMoviesNC() -> UINavigationController {
        let moviesVC = MoviesVC()
        moviesVC.tabBarItem =  UITabBarItem(title: "Popular", image: UIImage(systemName: "video"), selectedImage: UIImage(systemName: "video.fill"))
        moviesVC.tabBarItem.tag = 0
        return UINavigationController(rootViewController: moviesVC)
    }
    
    func createFavoritesNC() -> UINavigationController{ 
        let favoritesVC = FavoritesVC()
        favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        return UINavigationController(rootViewController: favoritesVC)
    }
}
