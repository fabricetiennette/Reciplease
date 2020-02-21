//
//  RecipeListViewController.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 13/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

class RecipeListViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Recipes list"
    }
}
