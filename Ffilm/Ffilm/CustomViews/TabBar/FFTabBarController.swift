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
        moviesVC.title = Strings.popularVCTitle
        if #available(iOS 13.0, *) {
            moviesVC.tabBarItem =  UITabBarItem(title: Strings.popularVCTabBar, image: Images.SFSymbols.tabBarPopularImage, selectedImage: Images.SFSymbols.tabBarPopularImageFill)
        } else {
            moviesVC.tabBarItem =  UITabBarItem(tabBarSystemItem: .search, tag: .zero)
        }
        moviesVC.tabBarItem.tag = .zero
        return UINavigationController(rootViewController: moviesVC)
    }

    func createFavoritesNC() -> UINavigationController {
        let favoritesVC = FavoritesVC()
        favoritesVC.title = Strings.favoritesVCTitle
        if #available(iOS 13.0, *) {
            favoritesVC.tabBarItem = UITabBarItem(title: Strings.favoritesVCTabBar, image: Images.SFSymbols.tabBarFavoriteImage, selectedImage: Images.SFSymbols.tabBarFavoriteImageFill)
        } else {
            favoritesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        }
        return UINavigationController(rootViewController: favoritesVC)
    }
}
