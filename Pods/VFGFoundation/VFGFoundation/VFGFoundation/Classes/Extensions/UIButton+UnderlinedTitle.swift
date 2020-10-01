//
//  UIButton+UnderlinedTitle.swift
//  VFGMVA10Group
//
//  Created by Mohamed Abd ElNasser on 7/11/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

extension UIButton {
    public func setUnderlinedTitle(title: String, font: UIFont, color: UIColor, state: UIControl.State) {
        let attrs: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: font,
            NSAttributedString.Key.foregroundColor: color,
            NSAttributedString.Key.underlineStyle: 1]

        let attributedString = NSMutableAttributedString(string: "")
        let buttonTitleStr = NSMutableAttributedString(string: title, attributes: attrs)
        attributedString.append(buttonTitleStr)
        setAttributedTitle(attributedString, for: state)
    }
}
