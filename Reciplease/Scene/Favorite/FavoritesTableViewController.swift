// swiftlint:disable force_cast
//
//  FavoritesTableViewController.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 21/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class FavoritesTableViewController: UITableViewController, Storyboarded {

    var viewModel: FavoriteViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
//        startAnimating()
        configureViewModel()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateMyFavoritesRecipes()
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

    func updateMyFavoritesRecipes() {
//        if viewModel.favorites.isEmpty {
//            let size = CGSize(width: 50, height: 50)
//            startAnimating(size, type: .pacman, color: .brown, fadeInAnimation: nil)
//        }
        viewModel.updateFavorites()
    }

    func configureViewModel() {
        viewModel.recipeHandler = { [weak self] recipe in
            guard let me = self else { return }
            me.viewModel.showRecipeDetail(with: recipe)
        }
        viewModel.favoriteIsNotEmptyHandler = { [weak self] in
            guard let me = self else { return }
            me.tableView.restore()
//            me.stopAnimating()
        }
        viewModel.favoritesIsEmptyHandler = { [weak self] in
            guard let me = self else { return }
            me.tableView.setEmptyMessage("No Favorites")
//            me.stopAnimating()
        }
        viewModel.reloadHandler = tableView.reloadData
    }
}

extension FavoritesTableViewController: NVActivityIndicatorViewable {}

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
        cell.configureCell(recipe: recipe, indexPath: indexPath)
        return cell
    }

    override func tableView(
        _ tableView: UITableView,
        didSelectRowAt indexPath: IndexPath
    ) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let selectedRecipeRow = tableView.cellForRow(at: indexPath) as? FavoriteCell
        viewModel.getDetails(of: selectedRecipeRow)
    }
}
