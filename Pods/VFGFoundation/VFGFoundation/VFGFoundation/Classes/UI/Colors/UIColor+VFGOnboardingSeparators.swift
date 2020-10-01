//
//  UIColor+VFGOnboardingSeparators.swift
//  VFGFoundation
//
//  Created by Hussein Kishk on 5/4/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation
extension UIColor {

    public static let VFGOnboardingSeparatorInProgress = UIColor.init(named: "VFGOnboardingSeparatorInProgress",
                                                                      in: Bundle.foundation,
                                                                      compatibleWith: nil) ?? UIColor.white

    public static let VFGOnboardingSeparatorSkipAction = UIColor.init(named: "VFGOnboardingSeparatorSkipAction",
                                                                      in: Bundle.foundation,
                                                                      compatibleWith: nil) ?? UIColor.white
}
