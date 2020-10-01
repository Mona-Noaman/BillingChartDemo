//
//  UIColor+VFGPageControl.swift
//  VFGFoundation
//
//  Created by Hussein Kishk on 5/13/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

extension UIColor {

    public static let VFGPageControlCurrentPage = UIColor.init(named: "VFGPageControlCurrentPage",
                                                               in: Bundle.foundation,
                                                               compatibleWith: nil) ?? UIColor.white

    public static let VFGPageControlTint = UIColor.init(named: "VFGPageControlTint",
                                                        in: Bundle.foundation,
                                                        compatibleWith: nil) ?? UIColor.white
}
