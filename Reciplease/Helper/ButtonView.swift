//
//  ButtonView.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 22/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

@IBDesignable
class ButtonView: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        updateStyle()
    }
}

private extension ButtonView {
    func updateStyle() {
        layer.cornerRadius = 6
    }
}
