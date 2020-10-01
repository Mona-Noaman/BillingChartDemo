//
//  UIColor+VFGBackgrounds.swift
//  VFGFoundation
//
//  Created by Hussien Gamal Mohammed on 4/13/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

extension UIColor {
    public static let VFGWhiteBackground = UIColor.init(named: "VFGWhiteBackground",
                                                        in: Bundle.foundation,
                                                        compatibleWith: nil) ?? UIColor.white

    public static let VFGWhiteBackgroundTwo = UIColor.init(named: "VFGWhiteBackgroundTwo",
                                                           in: Bundle.foundation,
                                                           compatibleWith: nil) ?? UIColor.white

    public static let VFGVeryLightGreyBackground = UIColor.init(named: "VFGVeryLightGreyBackground",
                                                                in: Bundle.foundation,
                                                                compatibleWith: nil) ?? UIColor.white

    public static let VFGRedBackground = UIColor.init(named: "VFGRedBackground",
                                                      in: Bundle.foundation,
                                                      compatibleWith: nil) ?? UIColor.white

    public static let VFGLightGreyBackground = UIColor.init(named: "VFGLightGreyBackground",
                                                            in: Bundle.foundation,
                                                            compatibleWith: nil) ?? UIColor.white

    public static let VFGRedDefaultBackground = UIColor.init(named: "VFGRedDefaultBackground",
                                                             in: Bundle.foundation,
                                                             compatibleWith: nil) ?? UIColor.white

    public static var quickActionsGradient: [CGColor] {
        return [UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor,
                UIColor(red: 169/255, green: 0/255, blue: 0/255, alpha: 1.0).cgColor]
    }
    public static var giftOverlayGradient: [CGColor] {
        return [UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0).cgColor,
                UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1.0).cgColor]
    }

    public static var VFGRedGradientDynamic: [CGColor] {
        return [UIColor.VFGRedGradientStart.cgColor,
                UIColor.VFGRedGradientEnd.cgColor]
    }
}
