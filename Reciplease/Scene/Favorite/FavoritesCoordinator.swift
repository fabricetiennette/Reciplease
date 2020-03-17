//
//  LearnCoordinator.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 21/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

class FavoritesCoordinator {

    var favoriteNavController = UINavigationController()
    var coreDataManager: CoreDataManager!

    init() {
        favoriteNavController.navigationBar.prefersLargeTitles = true
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let stack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: stack)
        start()
    }

    func start() {
        let viewModel = FavoriteViewModel(delegate: self, stack: coreDataManager)
        let viewController = FavoritesTableViewController.instantiate()
        viewController.viewModel = viewModel
        viewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart"), tag: 1)
        favoriteNavController.viewControllers = [viewController]
    }

    func showRecipeDetail(with selectedRecipe: SelectedRecipe) {
        let viewModel = RecipeDetailsViewModel(recipeSelected: selectedRecipe, stack: coreDataManager)
        let viewController = RecipeDetailsViewController.instantiate()
        viewController.viewModel = viewModel
        favoriteNavController.pushViewController(viewController, animated: true)
    }
}

extension FavoritesCoordinator: FavoriteViewModelDelegate {
    func showingRecipeDetails(with selectedRecipe: SelectedRecipe) {
        showRecipeDetail(with: selectedRecipe)
    }
}
