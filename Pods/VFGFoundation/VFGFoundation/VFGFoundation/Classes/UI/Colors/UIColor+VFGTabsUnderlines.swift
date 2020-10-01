//
//  UIColor+VFGTabsUnderlines.swift
//  VFGFoundation
//
//  Created by Hussien Gamal Mohammed on 4/13/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

extension UIColor {
    public static let VFGTabsUnderline = UIColor.init(named: "VFGTabsUnderline",
                                                      in: Bundle.foundation,
                                                      compatibleWith: nil) ?? UIColor.white
    public static let VFGTabsUnderlineRedOrange = UIColor.init(named: "VFGTabsUnderlineRedOrange",
                                                               in: Bundle.foundation,
                                                               compatibleWith: nil) ?? UIColor.white
    public static let VFGTabsUnderlineActiveText = UIColor.init(named: "VFGTabsUnderlineActiveText",
                                                                in: Bundle.foundation,
                                                                compatibleWith: nil) ?? UIColor.white
    public static let VFGTabsUnderlineInactiveText = UIColor.init(named: "VFGTabsUnderlineInactiveText",
                                                                  in: Bundle.foundation,
                                                                  compatibleWith: nil) ?? UIColor.white
    public static let VFGTabsUnderlinesHoverText = UIColor.init(named: "VFGTabsUnderlinesHoverText",
                                                                in: Bundle.foundation,
                                                                compatibleWith: nil) ?? UIColor.white
}
