//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 21/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController {

    @IBOutlet weak var recipeDetailsTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDetailsTableView.delegate = self
        recipeDetailsTableView.dataSource = self
    }
}

extension RecipeDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
           // #warning Incomplete implementation, return the number of sections
           return 3
       }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 100
        } else if indexPath.section > 0 {
            return 150
        }
        return 400
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath)
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeTimeCell", for: indexPath)
            return cell
        } else if indexPath.section > 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath)
            return cell
        }
        return UITableViewCell()
    }
}