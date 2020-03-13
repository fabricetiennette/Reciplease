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

    var viewModel: SearchViewModel!

    override func viewWillLayoutSubviews() {
        configureNavigationBar()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewModel()
        configureView()
    }

    @objc func tapView() {
        view.endEditing(true)
    }

    @IBAction func addButtonTapped(_ sender: Any) {
        view.endEditing(true)
        guard let ingredient = ingredientTextField.text else { return }
        viewModel.addIngredient(ingredient)
        ingredientTextField.text?.removeAll()
    }

    @IBAction func searchButtonTapped(_ sender: Any) {
        viewModel.searchForRecipes()
    }
}

private extension SearchViewController {
    func configureNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = viewModel.prefersLargeTitles
        navigationItem.title = viewModel.title
        ingredientTextField.addBottomBorderWithColor(color: .brown, width: 0.5)
    }

    func configureView() {
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapView)))
        emtpyMessage("Ingredients missing 😢")
    }

    func configureViewModel() {
        viewModel.errorHandler = { title, message in
            self.showAlert(title: title, message: message)
        }
        viewModel.messageHandler = { text in
            self.emtpyMessage(text)
        }
        viewModel.reloadHandler = tableView.reloadData
    }

    func emtpyMessage(_ text: String) {
        if viewModel.userIngredients.isEmpty {
            tableView.setEmptyMessage(text)
        } else {
            tableView.restore()
        }
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
