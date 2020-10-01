//
//  UIColor+VFGBars.swift
//  VFGFoundation
//
//  Created by Ahmed Sultan on 6/7/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

extension UIColor {
    public static let VFGChartBarsUnselected = UIColor.init(named: "VFGChartBarsUnselected",
                                                            in: Bundle.foundation,
                                                            compatibleWith: nil) ?? UIColor.lightGray

    public static let VFGRedProgressBar = UIColor.init(named: "VFGRedProgressBar",
                                                       in: Bundle.foundation,
                                                       compatibleWith: nil) ?? UIColor.lightGray

    public static let VFGChartBarsActive = UIColor.init(named: "VFGChartBarsActive",
                                                        in: Bundle.foundation,
                                                        compatibleWith: nil) ?? UIColor.lightGray

    public static let VFGChartBarsUnselectedRed = UIColor.init(named: "VFGChartBarsUnselectedRed",
                                                               in: Bundle.foundation,
                                                               compatibleWith: nil) ?? UIColor.lightGray
}
