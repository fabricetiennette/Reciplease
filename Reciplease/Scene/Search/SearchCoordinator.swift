//
//  SearchCoordinator.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 21/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

/// Manages everything launched from the Search tab in the app.
class SearchCoordinator {

    var navigationController: UINavigationController
    var coreDataManager: CoreDataManager!

    init(navigationController: UINavigationController = .init()) {
        self.navigationController = navigationController
        navigationController.navigationBar.prefersLargeTitles = true
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let stack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: stack)
        start()
    }

    func start() {
        let viewController = SearchViewController.instantiate()
        let viewModel = SearchViewModel(delegate: self)
        viewController.viewModel = viewModel
        viewController.tabBarItem = UITabBarItem(
            title: "Search",
            image: UIImage(systemName: "magnifyingglass"),
            tag: 0
        )
        navigationController.viewControllers = [viewController]
    }

    func searchingRecipes(with ingredient: String) {
        let viewModel = RecipeListViewModel(ingredient: ingredient, delegate: self)
        let viewController = RecipeListTableViewController.instantiate()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }

    func showRecipeDetail(with selectedRecipe: SelectedRecipe) {
        let viewModel = RecipeDetailsViewModel(
            recipeSelected: selectedRecipe,
            stack: coreDataManager
        )
        let viewController = RecipeDetailsViewController.instantiate()
        viewController.viewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}

extension SearchCoordinator: SearchViewModeldelegate {
    func searchForRecipes(with ingredient: String) {
        searchingRecipes(with: ingredient)
    }
}

extension SearchCoordinator: RecipeListViewModelDelegate {
    func recipeDetail(with selectedRecipe: SelectedRecipe) {
        showRecipeDetail(with: selectedRecipe)
    }
}
