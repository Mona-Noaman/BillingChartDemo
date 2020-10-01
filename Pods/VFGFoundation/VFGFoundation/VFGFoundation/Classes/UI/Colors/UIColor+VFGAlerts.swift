//
//  UIColor+VFGAlerts.swift
//  VFGFoundation
//
//  Created by Hussien Gamal Mohammed on 4/13/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

extension UIColor {
    public static let VFGAlertPositive = UIColor.init(named: "VFGAlertPositive",
                                                      in: Bundle.foundation,
                                                      compatibleWith: nil) ?? UIColor.white

    public static let VFGAlertNeutral = UIColor.init(named: "VFGAlertNeutral",
                                                     in: Bundle.foundation,
                                                     compatibleWith: nil) ?? UIColor.white
    public static let VFGAlertError = UIColor.init(named: "VFGAlertError",
                                                   in: Bundle.foundation,
                                                   compatibleWith: nil) ?? UIColor.white
}
