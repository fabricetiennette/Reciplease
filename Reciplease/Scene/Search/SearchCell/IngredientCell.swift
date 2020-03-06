//
//  IngredientCell.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 27/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

class IngredientCell: UITableViewCell {

    @IBOutlet private weak var userIngredient: UILabel!

    func configureCell(_ ingredient: [String], _ indexPath: IndexPath) {
        let ingredientText = ingredient[indexPath.row]
        userIngredient.text = ingredientText
    }
}
