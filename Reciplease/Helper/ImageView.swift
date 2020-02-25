//
//  ImageView.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 23/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

@IBDesignable
class ImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        updateStyle()
    }
}

private extension ImageView {
    func updateStyle() {
        roundCorners([.topRight, .topLeft], radius: 6)
        addOverlay()
    }

    func addOverlay() {
        let overlay: UIView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height))
        overlay.setGradientBackground(.clear, .black)
        overlay.layer.opacity = 0.6
        overlay.tag = 1

        // Check if overlay already exists before adding it
        if self.viewWithTag(1) == nil {
            self.addSubview(overlay)
        }
    }
}
