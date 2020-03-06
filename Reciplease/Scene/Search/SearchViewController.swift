// swiftlint:disable force_cast
//
//  SearchViewController.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 21/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, Storyboarded {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var searchButton: UIButton!
    @IBOutlet private weak var ingredientTextField: UITextField!
    @IBOutlet private weak var addButton: UIButton!

    var coordinator: SearchCoordinator?
    var viewModel: SearchViewModel!

    override func viewWillLayoutSubviews() {
        configureNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        ingredientTextField.resignFirstResponder()
        guard let ingredient = ingredientTextField.text else { return }
        viewModel.addIngredient(ingredient)
        ingredientTextField.text?.removeAll()
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        print("tapped")
        let ingredient = viewModel.ingredients
        coordinator?.searchForRecipes(with: ingredient)
    }
}

private extension SearchViewController {
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = viewModel.prefersLargeTitles
        navigationItem.title = viewModel.title
        ingredientTextField.addBottomBorderWithColor(color: .brown, width: 0.5)
    }

    func configureViewModel() {
        viewModel.errorHandler = { title, message in
            self.showAlert(title: title, message: message)
        }
        viewModel.reloadHandler = tableView.reloadData
    }
}

// MARK: - Table view data source

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return viewModel.numberOfRows(in: section)
    }

    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 70
        default:
            return 50
        }
    }

    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        let ingredient = viewModel.userIngredients
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchHeaderCell", for: indexPath) as! SearchHeaderCell
            cell.removeIngredientHandler = {
                self.viewModel.userIngredients.removeAll()
            }
            cell.configureCell(ingredient, searchButton)
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as! IngredientCell
            cell.configureCell(ingredient, indexPath)
            return cell
        }
        return UITableViewCell()
    }

    func tableView(
        _ tableView: UITableView,
        commit editingStyle: UITableViewCell.EditingStyle,
        forRowAt indexPath: IndexPath
    ) {
        if editingStyle == .delete {
            viewModel.userIngredients.remove(at: indexPath.row)
        }
    }
}
