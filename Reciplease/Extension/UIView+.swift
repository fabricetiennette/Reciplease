//
//  UIView+.swift
//  Reciplease
//
//  Created by Fabrice Etiennette on 21/02/2020.
//  Copyright © 2020 Fabrice Etiennette. All rights reserved.
//

import UIKit

extension UIView {
    func setGradientBackground(_ colorOne: UIColor, _ colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]

        layer.insertSublayer(gradientLayer, at: 0)
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }

    func addTopBorderWithColor(color: UIColor, width: CGFloat) {
           let border = CALayer()
           border.backgroundColor = color.cgColor
           border.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: width)
           self.layer.addSublayer(border)
       }

    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        self.layer.addSublayer(border)
    }

    func slideOut() {
        let transition1: CATransition = CATransition()
        let timeFunc1: CAMediaTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        transition1.duration = 1.5
        transition1.timingFunction = timeFunc1
        transition1.type = CATransitionType.push
        transition1.subtype = CATransitionSubtype.fromBottom
        self.layer.add(transition1, forKey: kCATransition)
    }

    func slideInFromTop() {
        let transition1: CATransition = CATransition()
        let timeFunc1: CAMediaTimingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition1.duration = 1.5
        transition1.timingFunction = timeFunc1
        transition1.type = CATransitionType.push
        transition1.subtype = CATransitionSubtype.fromTop
        self.layer.add(transition1, forKey: kCATransition)
    }
}
