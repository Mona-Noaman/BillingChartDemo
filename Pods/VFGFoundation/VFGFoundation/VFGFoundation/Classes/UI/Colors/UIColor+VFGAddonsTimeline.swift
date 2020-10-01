//
//  UIColor+VFGAddonsTimeline.swift
//  VFGFoundation
//
//  Created by Esraa Eldaltony on 7/20/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation
extension UIColor {
    public static let VFGTimelineCellActive = UIColor.init(named: "VFGTimelineCellActive",
                                                           in: Bundle.foundation,
                                                           compatibleWith: nil) ?? UIColor.white
    public static let VFGTimelineCellBorder = UIColor.init(named: "VFGTimelineCellBorder",
                                                           in: Bundle.foundation,
                                                           compatibleWith: nil) ?? UIColor.white
    public static let VFGTimelineSeparator = UIColor.init(named: "VFGTimelineSeparator",
                                                          in: Bundle.foundation,
                                                          compatibleWith: nil) ?? UIColor.white
}
