//
//  SearchHeaderCell.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 21/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

class SearchHeaderCell: UITableViewCell {

    @IBOutlet weak var clearButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    @IBAction func clearButtonTapped(_ sender: Any) {
        print("Clear button tapped")
    }
}
