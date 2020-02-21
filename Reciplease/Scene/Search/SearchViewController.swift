//
//  FirstViewController.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 13/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()

    }

    func setupNavBar() {
        let searchController = UISearchController(searchResultsController: nil)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        navigationItem.title = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
        definesPresentationContext = true
    }
}
