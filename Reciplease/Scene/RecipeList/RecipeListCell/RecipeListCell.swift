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
    @IBOutlet weak var heartIcon: UIImageView!

    var favoriteTapHandler: () -> Void = {}
    var source = ""
    var calories = 0.0
    var ingredientLines: [String] = []
    var url = ""

    private var recipe: Recipe!

    @IBAction func favoriteButtonTapped(_ sender: Any) {
        favoriteTapHandler()
        heartIcon.isHighlighted = (heartIcon.isHighlighted == true) ? false : true
      }

    func configureCell(recipe: Recipe, ingredient: String, indexPath: IndexPath) {
        self.recipe = recipe

        source = recipe.source
        calories = recipe.calories
        ingredientLines = recipe.ingredientLines
        url = recipe.url

        if let url = URL(string: recipe.image) {
            guard let data = try? Data(contentsOf: url) else { return }
            recipeImage.image = UIImage(data: data)
        }

        if recipe.time == 0.0 {
            recipeTime.text = "N.A"
        } else {
            recipeTime.text = "\(Int(recipe.time)) MINUTES"
        }

        recipeTitle.text = recipe.title
        recipeYield.text = String(recipe.yield)
        recipeIngredients.text = ingredient.replacingOccurrences(of: "+", with: ", ")
    }
}
