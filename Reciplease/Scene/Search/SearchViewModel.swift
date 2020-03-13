//
//  SearchViewModel.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 26/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import Foundation

protocol SearchViewModeldelegate: class {
    func searchForRecipes(with ingredient: String)
}

class SearchViewModel {

    private weak var delegate: SearchViewModeldelegate?

    var errorHandler: (_ title: String, _ message: String) -> Void = { _, _ in }
    var messageHandler: (_ text: String) -> Void = { _ in }
    var reloadHandler: () -> Void = {}
    var userIngredients: [String] = [] {
        didSet {
            messageHandler("Ingredients missing 😢")
            reloadHandler()
        }
    }

    init(delegate: SearchViewModeldelegate?) {
        self.delegate = delegate
    }

    var prefersLargeTitles: Bool {
        true
    }

    var title: String {
        "Search"
    }

    func numberOfRows(in section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return userIngredients.count
        }
    }

    func addIngredient(_ ingredient: String) {
        if ingredient.hasSpecialCharacters() {
            errorHandler("Error", "Please enter a valid ingredient")
        } else {
            userIngredients.append(ingredient)
        }
    }

    func searchForRecipes() {
        let ingredients = userIngredients.joined(separator: "+")
        delegate?.searchForRecipes(with: ingredients)
    }
}
