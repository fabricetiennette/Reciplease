//
//  LearnCoordinator.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 21/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

class FavoritesCoordinator: Coordinator {
    var favoriteNavController = NavigationController()

    init() {
        // Set up the master view controller
        favoriteNavController.navigationBar.prefersLargeTitles = true
        favoriteNavController.coordinator = self
        start()
    }

    func start() {
        let viewController = FavoritesTableViewController.instantiate()
        viewController.tabBarItem = UITabBarItem(title: "Favorite", image: UIImage(systemName: "heart"), tag: 1)
        viewController.coordinator = self
        favoriteNavController.viewControllers = [viewController]
    }
}
