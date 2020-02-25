//
//  ShadowCardView.swift
//  Baluchon
//
//  Created by Lilian on 30/12/2019.
//  Copyright © 2019 Fabrice Etiennette. All rights reserved.
//

import UIKit

@IBDesignable
class ShadowCardView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        updateStyle()
    }
}

private extension ShadowCardView {
    func updateStyle() {
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2
    }
}

@IBDesignable
class CardView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        updateStyle()
    }
}

private extension CardView {
    func updateStyle() {
        layer.cornerRadius = 10
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize.zero
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2
    }
}

@IBDesignable
class BorderView: UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        updateStyle()
    }
}

private extension BorderView {
    func updateStyle() {
        addTopBorderWithColor(color: .brown, width: 2)
        addBottomBorderWithColor(color: .brown, width: 2)
    }
}
