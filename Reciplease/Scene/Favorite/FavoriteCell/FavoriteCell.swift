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

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func favoriteButtonTapped(_ sender: Any) {
        print("fav button tapped in fav section")
        heartIcon.isHighlighted = (heartIcon.isHighlighted == true) ? false : true
      }
}
