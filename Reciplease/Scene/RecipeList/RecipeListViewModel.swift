//
//  RecipeListViewModel.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 02/03/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import Foundation

protocol RecipeListViewModelDelegate: class {
    func recipeDetail(with selectedRecipe: SelectedRecipe)
}
class RecipeListViewModel {

    weak var delegate: RecipeListViewModelDelegate?

    private let resipleaseClient: RecipleaseClient
    var ingredient: String
    var recipeHandler: (_ selectedRecipe: SelectedRecipe) -> Void = { _ in }
    var reloadHandler: () -> Void = {}
    var errorHandler: (_ title: String, _ message: String) -> Void = { _, _ in }
    var recipe: [Hits] = []
    var selectedRecipe: [RecipeListCell] = []

    init(ingredient: String,
         delegate: RecipeListViewModelDelegate?,
         resipleaseClient: RecipleaseClient = .init()
    ) {
        self.ingredient = ingredient
        self.delegate = delegate
        self.resipleaseClient = resipleaseClient
    }

    func getRecipes() {
        resipleaseClient.getRecipes(with: ingredient) { [weak self] result in
            guard let me = self else { return }
            switch result {
            case .success(let recipeData):
                me.recipe = recipeData.hits
                DispatchQueue.main.async {
                    me.reloadHandler()
                }
            case .failure:
                me.errorHandler("Error", "Cannot get recipes for the moment")
            }
        }
    }

    func showDetails(of selectedRow: RecipeListCell) {
        selectedRecipe.append(selectedRow)
        guard  let recipe = selectedRecipe.first else { return }
        let title = recipe.recipeTitle.text
        let image = recipe.recipeImage.image
        let source = recipe.source
        let url = recipe.url
        let yeild = recipe.recipeYield.text
        let ingredientLines = recipe.ingredientLines
        let calories = recipe.calories
        let time = recipe.recipeTime.text
        let ingredientChoose = ingredient

        let recipeSelected = SelectedRecipe(
            title: title,
            image: image,
            source: source,
            url: url,
            yield: yeild,
            ingredientLines: ingredientLines,
            calories: calories,
            time: time,
            ingredientChoose: ingredientChoose
        )
        recipeHandler(recipeSelected)
    }

    func showRecipeDetail(with recipe: SelectedRecipe) {
        delegate?.recipeDetail(with: recipe)
    }
}
