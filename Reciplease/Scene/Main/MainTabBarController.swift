//
//  MainTabBarController.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 21/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

/// A UITabBarController subclass that sets up our main coordinators as each of the 2 app tabs.
class MainTabBarController: UITabBarController, Storyboarded {

    let search = SearchCoordinator()
    let favorite = FavoritesCoordinator()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewControllers = [search.navigationController, favorite.favoriteNavController]
    }
}
