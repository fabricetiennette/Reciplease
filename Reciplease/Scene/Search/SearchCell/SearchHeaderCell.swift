//
//  SearchHeaderCell.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 21/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

class SearchHeaderCell: UITableViewCell {

    @IBOutlet private weak var clearButton: UIButton!
    @IBOutlet private weak var yourIngredientLabel: UILabel!

    var removeIngredientHandler: () -> Void = {}

    @IBAction func clearButtonTapped(_ sender: Any) {
        removeIngredientHandler()
    }

    func configureCell(_ ingredient: [String], _ searchButton: UIButton) {
        if ingredient.count == 0 {
            clearButton.isHidden = true
            yourIngredientLabel.isHidden = true
            searchButton.isHidden = true
        } else {
            clearButton.isHidden = false
            yourIngredientLabel.isHidden = false
            searchButton.isHidden = false
        }
    }
}
