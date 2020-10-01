//
//  UIColor+VFGTextColors.swift
//  VFGFoundation
//
//  Created by Hussien Gamal Mohammed on 4/13/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

extension UIColor {
    public static let VFGPrimaryText = UIColor.init(named: "VFGPrimaryText",
                                                    in: Bundle.foundation,
                                                    compatibleWith: nil) ?? UIColor.white

    public static let VFGSecondaryText = UIColor.init(named: "VFGSecondaryText",
                                                      in: Bundle.foundation,
                                                      compatibleWith: nil) ?? UIColor.white

    public static let VFGWhiteText = UIColor.init(named: "VFGWhiteText",
                                                  in: Bundle.foundation,
                                                  compatibleWith: nil) ?? UIColor.white

    public static let VFGRedOrangeText = UIColor.init(named: "VFGRedOrangeText",
                                                      in: Bundle.foundation,
                                                      compatibleWith: nil) ?? UIColor.white

    public static let VFGRedText = UIColor.init(named: "VFGRedText",
                                                in: Bundle.foundation,
                                                compatibleWith: nil) ?? UIColor.white

    public static let VFGUnselectedText = UIColor.init(named: "VFGUnselectedText",
                                                       in: Bundle.foundation,
                                                       compatibleWith: nil) ?? UIColor.white
}
