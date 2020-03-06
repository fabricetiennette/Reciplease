// swiftlint:disable force_cast
//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 21/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit
import SafariServices

class RecipeDetailsViewController: UIViewController, Storyboarded {

    @IBOutlet weak var recipeDetailsTableView: UITableView!

    var coordinator: SearchCoordinator?
    var viewModel: RecipeDetailsViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    @IBAction func getDirectionButtonTapped(_ sender: Any) {
        guard let recipe = viewModel.recipeSelected.url else { return }
        if let url = URL(string: recipe) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
}

extension RecipeDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
           // #warning Incomplete implementation, return the number of sections
           return 4
       }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 3:
            return viewModel.recipeSelected.ingredientLines.count
        default:
            return 1
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 375
        case 1:
            return 150
        case 2:
            return 60
        default:
            return 60
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let recipe = viewModel.recipeSelected
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! TitleCell
                cell.configureCell(recipe: recipe, indexPath: indexPath)
                return cell
            case 1:
                let cell = tableView.dequeueReusableCell(withIdentifier: "recipeTimeCell", for: indexPath) as! RecipePTKCell
                cell.configureCell(recipe: recipe, indexPath: indexPath)
                return cell
            case 2:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientTextCell", for: indexPath)
                return cell
            case 3:
                let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as! IngredientsListCell
                cell.configureCell(recipe: recipe, indexPath: indexPath)
                return cell
            default:
                break
        }
        return UITableViewCell()
    }
}
