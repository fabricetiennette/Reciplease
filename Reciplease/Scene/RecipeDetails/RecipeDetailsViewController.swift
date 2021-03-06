// swiftlint:disable force_cast
//
//  RecipeDetailsViewController.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 21/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var favoriteUIBarButton: UIBarButtonItem!

    var viewModel: RecipeDetailsViewModel!

    override func viewWillLayoutSubviews() {
        navigationController?.navigationBar.prefersLargeTitles = false
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }

    @IBAction func addFavoriteTapped(_ sender: Any) {
        viewModel.makeFavoriteOrNot(with: favoriteUIBarButton)
    }

    @IBAction func getDirectionButtonTapped(_ sender: Any) {
        viewModel.openRecipeWebPage()
    }
}

private extension RecipeDetailsViewController {
    func configureViewModel() {
        favoriteUIBarButton.accessibilityIdentifier = "favoriteBarButton"

        viewModel.errorHandler = { [weak self] title, message in
            guard let me = self else { return }
            me.showAlert(title: title, message: message)
        }

        viewModel.safariServicesHandler = { [weak self] viewController in
            guard let me = self else { return }
            me.present(viewController, animated: true)
        }
    }
}

extension RecipeDetailsViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
           return 4
       }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.numberOfRowsInSection(section)
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
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

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let recipe = viewModel.recipeSelected
            switch indexPath.section {
            case 0:
                let cell = tableView.dequeueReusableCell(withIdentifier: "titleCell", for: indexPath) as! TitleCell
                cell.configureCell(
                    recipe: recipe,
                    favoriteButton: favoriteUIBarButton,
                    indexPath: indexPath
                )
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
            default: break
        }
        return UITableViewCell()
    }
}
