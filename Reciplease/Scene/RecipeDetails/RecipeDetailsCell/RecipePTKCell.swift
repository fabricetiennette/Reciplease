//
//  RecipePTKCell.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 27/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

class RecipePTKCell: UITableViewCell {

    @IBOutlet weak var yeildLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var caloriesLabel: UILabel!

    private var recipe: SelectedRecipe!

    func configureCell(recipe: SelectedRecipe, indexPath: IndexPath) {
        self.recipe = recipe

        guard let calories = recipe.calories else { return }

        yeildLabel.text = recipe.yield
        totalTimeLabel.text = recipe.time
        caloriesLabel.text = "\(Int(calories))"
    }
}
