//
//  UIColor+VFGShimmer.swift
//  VFGFoundation
//
//  Created by Hussien Gamal Mohammed on 4/13/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

extension UIColor {
    public static let VFGShimmerViewEdge = UIColor.init(named: "VFGShimmerViewEdge",
                                                        in: Bundle.foundation,
                                                        compatibleWith: nil) ?? UIColor.white

    public static let VFGShimmerViewCenter = UIColor.init(named: "VFGShimmerViewCenter",
                                                          in: Bundle.foundation,
                                                          compatibleWith: nil) ?? UIColor.white

}
