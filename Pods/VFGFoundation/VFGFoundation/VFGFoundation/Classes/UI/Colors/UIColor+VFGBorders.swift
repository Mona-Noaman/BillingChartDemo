//
//  UIColor+VFGBorders.swift
//  VFGFoundation
//
//  Created by Mohamed Abd ElNasser on 6/2/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

extension UIColor {
    public static let VFGRedOrangeBorder = UIColor.init(named: "VFGRedOrangeBorder",
                                                        in: Bundle.foundation,
                                                        compatibleWith: nil) ?? UIColor.white
    public static let VFGGreyWhiteBorder = UIColor.init(named: "VFGGreyWhiteBorder",
                                                        in: Bundle.foundation,
                                                        compatibleWith: nil) ?? UIColor.white
}
