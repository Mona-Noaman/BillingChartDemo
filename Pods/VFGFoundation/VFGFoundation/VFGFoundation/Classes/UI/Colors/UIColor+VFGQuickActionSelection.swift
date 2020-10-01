//
//  UIColor+VFGQuickActionSelection.swift
//  VFGFoundation
//
//  Created by Hamsa Hassan on 7/1/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

extension UIColor {
    public static let VFGActiveSelectionOutline = UIColor.init(named: "VFGActiveSelectionOutline",
                                                               in: Bundle.foundation,
                                                               compatibleWith: nil) ?? UIColor.white

    public static let VFGActiveSelectionText = UIColor.init(named: "VFGActiveSelectionText",
                                                            in: Bundle.foundation,
                                                            compatibleWith: nil) ?? UIColor.black

    public static let VFGDefaultSelectionOutline = UIColor.init(named: "VFGDefaultSelectionOutline",
                                                                in: Bundle.foundation,
                                                                compatibleWith: nil) ?? UIColor.white

    public static let VFGDefaultSelectionText = UIColor.init(named: "VFGDefaultSelectionText",
                                                             in: Bundle.foundation,
                                                             compatibleWith: nil) ?? UIColor.black
}
