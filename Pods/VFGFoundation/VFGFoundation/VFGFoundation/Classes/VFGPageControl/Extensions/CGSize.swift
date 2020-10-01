//
//  CGSize.swift
//  VFGFoundation
//
//  Created by Yahya Saddiq on 3/29/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import CoreGraphics

extension CGSize {
    public init(side: CGFloat) {
        self.init(width: side, height: side)
    }
}
