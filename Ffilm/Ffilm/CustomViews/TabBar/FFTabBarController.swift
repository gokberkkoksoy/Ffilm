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
        viewControllers = [createMoviesNC(), createFavoritesNC()]
        UITabBar.appearance().barStyle = .default //  .black gives a darker tone
    }
    
    func createMoviesNC() -> UINavigationController {
        let moviesVC = MoviesVC()
        moviesVC.title = UIConstants.popularVCTitle
        if #available(iOS 13.0, *) {
            moviesVC.tabBarItem =  UITabBarItem(title: UIConstants.popularVCTabBar, image: UIImage(systemName: "video"), selectedImage: UIImage(systemName: "video.fill"))
        } else {
            moviesVC.tabBarItem =  UITabBarItem(tabBarSystemItem: .search, tag: 0)
        }
        moviesVC.tabBarItem.tag = 0
        return UINavigationController(rootViewController: moviesVC)
    }
    
    func createFavoritesNC() -> UINavigationController{ 
        let favoritesVC = FavoritesVC()
        favoritesVC.title = UIConstants.favoritesVCTitle
        if #available(iOS 13.0, *) {
            favoritesVC.tabBarItem = UITabBarItem(title: UIConstants.favoritesVCTabBar, image: UIImage(systemName: "star"), selectedImage: UIImage(systemName: "star.fill"))
        } else {
            favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        }
        return UINavigationController(rootViewController: favoritesVC)
    }
}
