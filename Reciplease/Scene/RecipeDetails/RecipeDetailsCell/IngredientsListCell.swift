//
//  IngredientsListCell.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 27/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

class IngredientsListCell: UITableViewCell {

    @IBOutlet weak var ingredientLabel: UILabel!

    private var recipe: SelectedRecipe!

    func configureCell(recipe: SelectedRecipe, indexPath: IndexPath) {
        self.recipe = recipe

        ingredientLabel.text = recipe.ingredientLines[indexPath.row]
    }
}
