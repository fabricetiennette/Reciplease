//
//  FavoriteViewModel.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 04/03/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import Foundation
import CoreData

protocol FavoriteViewModelDelegate: class {
    func showingRecipeDetails(with selectedRecipe: SelectedRecipe)
}

class FavoriteViewModel {

    private weak var delegate: FavoriteViewModelDelegate?
    private let stack: CoreDataStack

    var recipeHandler: (_ selectedRecipe: SelectedRecipe) -> Void = { _ in }
    var favoriteIsNotEmptyHandler: () -> Void = {}
    var favoritesIsEmptyHandler: () -> Void = {}
    var reloadHandler: () -> Void = {}
    var favorites: [MyRecipe] = [] {
        didSet {
            reloadHandler()
        }
    }

    init(delegate: FavoriteViewModelDelegate?, stack: CoreDataStack = .init()) {
        self.delegate = delegate
        self.stack = stack
    }

    func updateFavorites() {
        stack.getRecipes { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let recipes):
                    self.favorites = recipes
                    self.favoriteIsNotEmptyHandler()
                case .failure:
                    self.favoritesIsEmptyHandler()
                }
            }
        }
    }

    func getDetails(of recipeSelected: FavoriteCell?) {
        guard let recipe = recipeSelected else { return }
        let ingredientLines = recipe.ingredientLines
        let title = recipe.recipeTitle.text
        let image = recipe.recipeImage.image
        let source = recipe.source
        let url = recipe.url
        let yeild = recipe.recipeYield.text
        let calories = recipe.calories
        let time = recipe.recipeTime.text
        let ingredientChoose = recipe.recipeIngredients.text

        let recipeSelected = SelectedRecipe(
            title: title,
            image: image,
            source: source,
            url: url,
            yield: yeild,
            ingredientLines: ingredientLines,
            calories: calories,
            time: time,
            ingredientChoose: ingredientChoose,
            isFavorite: true
        )
        recipeHandler(recipeSelected)
    }

    func showRecipeDetail(with recipe: SelectedRecipe) {
        delegate?.showingRecipeDetails(with: recipe)
    }
}
