// swiftlint:disable force_cast
//
//  RecipeListTableViewController.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 13/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class RecipeListTableViewController: UITableViewController, Storyboarded {

    var viewModel: RecipeListViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureNavigationBar()
        getMyRecipes()
    }
}

extension RecipeListTableViewController: NVActivityIndicatorViewable {

    private func configureNavigationBar() {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Recipes"
        navigationItem.largeTitleDisplayMode = .always
        navigationController.navigationBar.sizeToFit()
    }

    private func getMyRecipes() {
        if viewModel.recipe.isEmpty {
            let size = CGSize(width: 50, height: 50)
            startAnimating(
                size,
                type: .pacman,
                color: .brown,
                fadeInAnimation: nil
            )
            viewModel.getRecipes()
        }
    }

    private func configureViewModel() {
        tableView.accessibilityIdentifier = "recipeListId"
        viewModel.recipeHandler = { [weak self] recipe in
            guard let me = self else { return }
            me.viewModel.showRecipeDetail(with: recipe)
        }

        viewModel.reloadHandler = { [weak self] in
            guard let me = self else { return }
            DispatchQueue.main.async {
                me.tableView.reloadData()
                me.stopAnimating()
            }
        }

        viewModel.errorHandler = { [weak self] title, message in
            guard let me = self else { return }
            DispatchQueue.main.async {
                me.showAlertWithDismissAction(title: title, message: message)
                me.stopAnimating()
            }
        }
    }
}

    // MARK: - Table view data source

extension RecipeListTableViewController {

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.recipe.count
    }

    override func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 250
    }

    override func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let recipe = viewModel.recipe[indexPath.row].recipe
        let ingredient =  viewModel.ingredient
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeListCell", for: indexPath) as! RecipeListCell
        cell.accessibilityIdentifier = "recipeListCell_\(indexPath.row)"
        cell.configureCell(recipe: recipe, ingredient: ingredient, indexPath: indexPath)
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let selectedCell = tableView.cellForRow(at: indexPath) as! RecipeListCell
        viewModel.getDetails(of: selectedCell)
    }
}
