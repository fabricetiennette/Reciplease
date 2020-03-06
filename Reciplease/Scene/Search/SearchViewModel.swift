//
//  SearchViewModel.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 26/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import Foundation

class SearchViewModel {

    var reloadHandler: () -> Void = {}
    var errorHandler: (_ title: String, _ message: String) -> Void = { _, _ in }
    var userIngredients: [String] = [] {
        didSet {
            reloadHandler()
        }
    }

    var prefersLargeTitles: Bool {
        true
    }

    var title: String {
        "Search"
    }

    var ingredients: String {
        userIngredients.joined(separator: "+")
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
        }
        userIngredients.append(ingredient)
    }
}
