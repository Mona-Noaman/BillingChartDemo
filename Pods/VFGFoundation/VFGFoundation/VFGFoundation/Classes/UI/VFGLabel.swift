//
//  VFGLabel.swift
//  VFGFoundation
//
//  Created by Hussien Gamal Mohammed on 7/9/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

@IBDesignable
public class VFGLabel: UILabel {
    @IBInspectable var fontName: Int = 0 {
        willSet(newValue) {
            font = font(of: FontType(rawValue: newValue) ?? FontType.lite, with: fontSize)
        }
    }

    @IBInspectable var fontSize: CGFloat = 22 {
        willSet(newValue) {
            font = font(of: FontType(rawValue: fontName) ?? FontType.lite, with: newValue)
        }
    }

    func font(of type: FontType, with size: CGFloat) -> UIFont {
        switch type {
        case .regular:
            return UIFont.vodafoneRegular(size)
        case .lite:
            return UIFont.vodafoneLite(size)
        case .bold:
            return UIFont.vodafoneBold(size)
        }
    }
}
enum FontType: Int {
    case lite = 0
    case regular = 1
    case bold = 2
}
