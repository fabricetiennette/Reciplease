//
//  RecipeDetailsViewModel.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 04/03/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import Foundation

class RecipeDetailsViewModel {

    var recipeSelected: SelectedRecipe

    init(recipeSelected: SelectedRecipe) {
        self.recipeSelected = recipeSelected
    }
}
