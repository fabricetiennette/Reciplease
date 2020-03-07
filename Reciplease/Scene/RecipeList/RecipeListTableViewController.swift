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

    override func viewWillLayoutSubviews() {
        configureNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        if viewModel.recipe.isEmpty {
            let size = CGSize(width: 50, height: 50)
            startAnimating(size, type: .pacman, color: .brown, fadeInAnimation: nil)
            viewModel.getRecipes()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }
}

extension RecipeListTableViewController: NVActivityIndicatorViewable {

    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Recipes list"
    }

    func configureViewModel() {
        viewModel.recipeHandler = { [weak self] recipe in
            guard let me = self else { return }
            me.viewModel.showRecipeDetail(with: recipe)
        }

        viewModel.reloadHandler = { [weak self] in
            guard let me = self else { return }
            me.tableView.reloadData()
            me.stopAnimating()
        }

        viewModel.errorHandler = { [weak self] title, message in
            guard let me = self else { return }
            me.showAlert(title: title, message: message)
            me.stopAnimating()
        }
    }
}

extension RecipeListTableViewController {

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.recipe.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipe = viewModel.recipe[indexPath.item].recipe
        let ingredient =  viewModel.ingredient
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeListCell", for: indexPath) as! RecipeListCell
        cell.favoriteTapHandler = {
//            viewModel.
        }
        cell.configureCell(recipe: recipe, ingredient: ingredient, indexPath: indexPath)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let selectedCell = tableView.cellForRow(at: indexPath) as! RecipeListCell
        viewModel.showDetails(of: selectedCell)
    }
}
