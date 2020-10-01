//
//  UIView+BackgroundColor.swift
//  VFGMVA10Group
//
//  Created by Sandra Morcos on 7/25/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

extension UIView {
    public func setGradientBackgroundColor(colors: [CGColor]) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.frame = bounds
        layer.insertSublayer(gradientLayer, at: 0)
        layer.replaceSublayer(gradientLayer, with: gradientLayer)
    }
}
