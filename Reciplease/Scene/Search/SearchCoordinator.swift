//
//  SearchCoordinator.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 21/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

/// Manages everything launched from the Search tab in the app.
class SearchCoordinator: Coordinator {
    var navigationController: NavigationController

    init(navigationController: NavigationController = .init()) {
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.coordinator = self
        start()
    }

    func start() {
        let viewController = SearchViewController.instantiate()
        let viewModel = SearchViewModel()
        viewController.viewModel = viewModel
        viewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 0)
        viewController.coordinator = self
        navigationController.viewControllers = [viewController]
    }

    func searchForRecipes(with ingredient: String) {
        let viewModel = RecipeListViewModel(ingredient: ingredient)
        let viewController = RecipeListTableViewController.instantiate()
        viewController.viewModel = viewModel
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }

    func showRecipeDetail(with selectedRecipe: SelectedRecipe) {
        let viewModel = RecipeDetailsViewModel(recipeSelected: selectedRecipe)
        let viewController = RecipeDetailsViewController.instantiate()
        viewController.viewModel = viewModel
        viewController.coordinator = self
        navigationController.pushViewController(viewController, animated: true)
    }
}
