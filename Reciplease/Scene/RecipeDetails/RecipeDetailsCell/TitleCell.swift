//
//  TitleCell.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 26/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    @IBOutlet weak var imageFromRecipe: UIImageView!

    private var recipe: SelectedRecipe!

    func configureCell(recipe: SelectedRecipe, indexPath: IndexPath) {
        self.recipe = recipe

        imageFromRecipe.image = recipe.image
        titleLabel.text = recipe.title
        sourceLabel.text = recipe.source
    }
}
