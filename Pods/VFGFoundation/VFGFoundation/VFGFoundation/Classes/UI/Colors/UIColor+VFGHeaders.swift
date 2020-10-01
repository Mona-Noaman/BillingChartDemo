//
//  UIColor+VFGHeaders.swift
//  VFGFoundation
//
//  Created by Hussien Gamal Mohammed on 4/13/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

extension UIColor {
    public static let VFGWhiteHeader = UIColor.init(named: "VFGWhiteHeader",
                                                    in: Bundle.foundation,
                                                    compatibleWith: nil) ?? UIColor.white

    public static let VFGRedHeader = UIColor.init(named: "VFGRedHeader",
                                                  in: Bundle.foundation,
                                                  compatibleWith: nil) ?? UIColor.white

    public static let VFGDarkHeader = UIColor.init(named: "VFGDarkHeader",
                                                   in: Bundle.foundation,
                                                   compatibleWith: nil) ?? UIColor.white

    public static let VFGDarkGreyTwoHeader = UIColor.init(named: "VFGDarkGreyTwoHeader",
                                                          in: Bundle.foundation,
                                                          compatibleWith: nil) ?? UIColor.darkGray
    public static let VFGDarkGreyHeader = UIColor.init(named: "VFGDarkGreyHeader",
                                                       in: Bundle.foundation,
                                                       compatibleWith: nil) ?? UIColor.darkGray
}
