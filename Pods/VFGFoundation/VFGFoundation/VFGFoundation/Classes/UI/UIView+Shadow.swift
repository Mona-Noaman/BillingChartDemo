//
//  UIView+Shadow.swift
//  VFGFoundation
//
//  Created by Tomasz Czyżak on 27/05/2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

extension UIView {

    public func configureShadow(offset: CGSize = CGSize(width: 0.0, height: 2.0),
                                radius: CGFloat = 6.0,
                                opacity: Float = 0.12) {
        layer.cornerRadius = radius
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = offset
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        layer.masksToBounds = false
    }

}
