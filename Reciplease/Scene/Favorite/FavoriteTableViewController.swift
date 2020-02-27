//
//  FavoriteTableViewController.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 21/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

class FavoriteTableViewController: UITableViewController {

    override func viewWillLayoutSubviews() {
        configureNavBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func cellTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "RecipeDetails", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RecipeDetails")
        navigationController!.pushViewController(vc, animated: true)
    }
}

extension FavoriteTableViewController {

    func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Favorite"
    }
}

extension FavoriteTableViewController {

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeFavorite", for: indexPath)
        return cell
    }
}
