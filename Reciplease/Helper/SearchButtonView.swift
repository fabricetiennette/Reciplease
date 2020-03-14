//
//  SearchButtonView.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 13/03/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

@IBDesignable
class SearchButtonView: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        updateStyle()
    }
}

private extension SearchButtonView {
    func updateStyle() {
        roundCorners([.topRight, .topLeft], radius: 20)
    }
}
