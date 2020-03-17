// swiftlint:disable force_cast
//
//  FavoritesTableViewController.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 21/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController, Storyboarded {

    var viewModel: FavoriteViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.updateFavorites()
        configureNavBar()
    }
}

private extension FavoritesTableViewController {

    func configureNavBar() {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Favorites"
        navigationItem.largeTitleDisplayMode = .always
        navigationController.navigationBar.sizeToFit()
    }

    func configureViewModel() {
        tableView.accessibilityIdentifier = "favoritesTableView"
        viewModel.recipeHandler = { [weak self] recipe in
            guard let me = self else { return }
            me.viewModel.showRecipeDetail(with: recipe)
        }
        viewModel.favoriteIsNotEmptyHandler = { [weak self] in
            guard let me = self else { return }
            me.tableView.restore()
        }
        viewModel.favoritesIsEmptyHandler = { [weak self] in
            guard let me = self else { return }
            me.tableView.setEmptyMessage("No Favorites")
        }
        viewModel.reloadHandler = tableView.reloadData
    }
}

    // MARK: - Table view data source

extension FavoritesTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.favorites.count
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
        let recipe = viewModel.favorites[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeFavorite", for: indexPath) as! FavoriteCell
        cell.accessibilityIdentifier = "recipeFavorite_\(indexPath.row)"
        cell.configureCell(recipe: recipe, indexPath: indexPath)
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let recipeSelected = tableView.cellForRow(at: indexPath) as? FavoriteCell
        viewModel.getDetails(of: recipeSelected)
    }
}
