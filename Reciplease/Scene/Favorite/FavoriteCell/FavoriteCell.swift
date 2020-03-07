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
    @IBOutlet weak var heartIcon: UIImageView!

    private var recipe: SelectedRecipe!
    var favoriteHandler: () -> Void = { }

    @IBAction func favoriteButtonTapped(_ sender: Any) {
        favoriteHandler()
        heartIcon.isHighlighted = (heartIcon.isHighlighted == true) ? false : true
      }

    func configureCell(recipe: SelectedRecipe, indexPath: IndexPath) {
        self.recipe = recipe

        //        source = recipe.source
        //        calories = recipe.calories
        //        ingredientLines = recipe.ingredientLines
        //        url = recipe.url

        //        if let url = URL(string: recipe.image) {
        //            guard let data = try? Data(contentsOf: url) else { return }
        recipeImage.image = recipe.image
        //        }
        //        if recipe.time == 0.0 {
        //            recipeTime.text = "N.A"
        //        } else {
        recipeTime.text = recipe.time
        //        }

        recipeTitle.text = recipe.title
        recipeYield.text = recipe.yield
        recipeIngredients.text = recipe.ingredientChoose
    }
}
