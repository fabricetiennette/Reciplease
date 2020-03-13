//
//  RecipeListCell.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 27/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

class RecipeListCell: UITableViewCell {

    @IBOutlet weak var recipeImage: ImageView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeTime: UILabel!
    @IBOutlet weak var recipeYield: UILabel!
    @IBOutlet weak var recipeIngredients: UILabel!

    var source = ""
    var calories = 0.0
    var ingredientLines: [String] = []
    var url = ""

    private var recipe: Recipe!

    func configureCell(recipe: Recipe, ingredient: String, indexPath: IndexPath) {
        self.recipe = recipe

        if let url = URL(string: recipe.image) {
            if let data = try? Data(contentsOf: url) {
                recipeImage.image = UIImage(data: data)
            }
        }

        if recipe.time == 0.0 {
            recipeTime.text = "N.A"
        } else {
            recipeTime.text = "\(Int(recipe.time)) MINUTES"
        }

        source = recipe.source
        calories = recipe.calories
        ingredientLines = recipe.ingredientLines
        url = recipe.url
        recipeTitle.text = recipe.title
        recipeYield.text = String(recipe.yield)
        recipeIngredients.text = ingredient.replacingOccurrences(of: "+", with: ", ")
    }
}
