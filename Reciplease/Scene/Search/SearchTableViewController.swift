//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 21/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var searchButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "RecipeList", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RecipeList")
        navigationController!.pushViewController(vc, animated: true)
    }
}

extension SearchViewController {

    func setupNavBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "What's in your fridge ?"
        navigationItem.title = "Search"
        definesPresentationContext = true
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 6
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        while indexPath.section == 0 {
            return 60
        }
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchHeaderCell", for: indexPath)
            return cell
        } else if indexPath.section > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
            return cell
        }
        return UITableViewCell()
    }

}
