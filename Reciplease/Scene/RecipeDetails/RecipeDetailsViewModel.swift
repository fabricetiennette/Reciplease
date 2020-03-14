//
//  RecipeDetailsViewModel.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 04/03/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import Foundation
import SafariServices
import CoreData

class RecipeDetailsViewModel {

    private let stack: CoreDataStack
    private(set) var recipeSelected: SelectedRecipe

    var safariServicesHandler: (_ vc: SFSafariViewController ) -> Void = { _ in }
    var errorHandler: (_ title: String, _ message: String) -> Void = { _, _ in }

    init(recipeSelected: SelectedRecipe, stack: CoreDataStack = .init()) {
        self.recipeSelected = recipeSelected
        self.stack = stack
    }

    func stackErrorHandler() {
        stack.errorHandler = { title, message in
            self.errorHandler(title, message)
        }
    }

    private func recipeToBeSaved(
        _ recipe: SelectedRecipe,
        _ favoriteB: UIBarButtonItem
    ) {
        guard let title = recipe.title else { return }
        let check = stack.isEntityExist(title)
        if check {
            errorHandler("Error", "Already in your favorites")
            favoriteB.image = UIImage(systemName: "heart")
        } else {
            stack.saveRecipeInStack(recipe)
        }
    }

    private func recipeToBeDeleted(_ recipe: SelectedRecipe) {
        stack.deleteOneRecipeInStack(recipe)
    }

    func openRecipeWebPage() {
        guard let recipe = recipeSelected.url else { return }
        if let url = URL(string: recipe) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            let vc = SFSafariViewController(url: url, configuration: config)
            safariServicesHandler(vc)
        }
    }

    func makeFavoriteOrNot(with favoriteButton: UIBarButtonItem) {
        let fill = UIImage(systemName: "heart.fill")
        let notFill = UIImage(systemName: "heart")
        let recipe = recipeSelected
        favoriteButton.image = (favoriteButton.image == fill) ? notFill : fill
        if favoriteButton.image == fill {
            recipeToBeSaved(recipe, favoriteButton)
        } else {
            recipeToBeDeleted(recipe)
        }
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        switch section {
        case 3:
            return recipeSelected.ingredientLines.count
        default:
            return 1
        }
    }
}