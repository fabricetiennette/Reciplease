//
//  RecipeListTableViewController.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 13/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

class RecipeListTableViewController: UITableViewController {

    override func viewWillLayoutSubviews() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Recipes list"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func recipeTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "RecipeDetails", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RecipeDetails")
        navigationController!.pushViewController(vc, animated: true)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeListCell", for: indexPath)
        return cell
    }
}
