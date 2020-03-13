//
//  FavoriteCell.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 25/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {

    @IBOutlet weak var recipeImage: ImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeYield: UILabel!
    @IBOutlet weak var recipeIngredients: UILabel!

    var source = ""
    var calories = 0.0
    var ingredientLines: [String] = []
    var url = ""

    private var recipe: MyRecipe!

    func configureCell(recipe: MyRecipe, indexPath: IndexPath) {
        self.recipe = recipe

        guard let sourceR = recipe.source,
            let ingredient = recipe.ingredientLines,
            let link = recipe.url else { return }

        if let data = recipe.image {
            recipeImage.image = UIImage(data: data)
        }

        source = sourceR
        calories = recipe.calories
        ingredientLines = ingredient
        url = link
        recipeTime.text = recipe.time
        recipeTitle.text = recipe.title
        recipeYield.text = recipe.yield
        recipeIngredients.text = recipe.ingredientsChoose?.replacingOccurrences(of: "+", with: ", ")
    }
}
