//
//  UIColor+VFGFilter.swift
//  VFGFoundation
//
//  Created by Ahmed Sultan on 4/29/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

extension UIColor {
    public static let VFGFilterSelectedBg = UIColor.init(named: "VFGFilterSelectedBg",
                                                         in: Bundle.foundation,
                                                         compatibleWith: nil) ?? UIColor.blue
    public static let VFGFilterUnselectedBg = UIColor.init(named: "VFGFilterUnselectedBg",
                                                           in: Bundle.foundation,
                                                           compatibleWith: nil) ?? UIColor.white
    public static let VFGFilterSelectedText = UIColor.init(named: "VFGFilterSelectedText",
                                                           in: Bundle.foundation,
                                                           compatibleWith: nil) ?? UIColor.white
    public static let VFGFilterUnselectedText = UIColor.init(named: "VFGFilterUnselectedText",
                                                             in: Bundle.foundation,
                                                             compatibleWith: nil) ?? UIColor.darkGray
}
