//
//  UIColor+VFGHyperlinks.swift
//  VFGFoundation
//
//  Created by Hussien Gamal Mohammed on 4/13/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

extension UIColor {
    public static let VFGLinkText = UIColor.init(named: "VFGLinkText",
                                                 in: Bundle.foundation,
                                                 compatibleWith: nil) ?? UIColor.white
    public static let VFGLinkWhiteText = UIColor.init(named: "VFGLinkWhiteText",
                                                      in: Bundle.foundation,
                                                      compatibleWith: nil) ?? UIColor.white
    public static let VFGLinkAnthraciteText = UIColor.init(named: "VFGLinkAnthraciteText",
                                                           in: Bundle.foundation,
                                                           compatibleWith: nil) ?? UIColor.white
    public static let VFGLinkDarkGreyText = UIColor.init(named: "VFGLinkDarkGreyText",
                                                         in: Bundle.foundation,
                                                         compatibleWith: nil) ?? UIColor.white
}
