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

    var coordinator: FavoritesCoordinator?
    let viewModel = FavoriteViewModel()

    override func viewWillLayoutSubviews() {
        configureNavBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FavoritesTableViewController {

    func configureNavBar() {
        if viewModel.favorites.count == 0 {
            navigationController?.navigationBar.prefersLargeTitles = false
            tableView.setEmptyMessage("No Favorites")
        } else {
            navigationController?.navigationBar.prefersLargeTitles = true
            tableView.restore()
        }
        navigationItem.title = "Favorites"
    }
}

    // MARK: - Table view data source

extension FavoritesTableViewController {

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favorites.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeFavorite", for: indexPath) as! FavoriteCell
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let indexPath = tableView.indexPathForSelectedRow else { return }
//        let _ = tableView.cellForRow(at: indexPath)
    }
}
