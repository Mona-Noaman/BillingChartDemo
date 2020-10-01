//
//  UIView+RoundCorners.swift
//  VFGMVA10Group
//
//  Created by Sandra Morcos on 6/17/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

extension UIView: PropertyStoring {

    public typealias ObjectType = CGSize

    private struct ObjectKeys {
        static var bounds = 0
    }

    var oldViewSize: CGSize? {
        get {
            return getAssociatedObject(&ObjectKeys.bounds)
        }
        set {
            setAssociatedObject(&ObjectKeys.bounds, newValue: newValue)
        }
    }

    internal func roundUpperCornersOs10Imp(cornerRadius: CGFloat) {
        guard oldViewSize != bounds.size else {
            return
        }
        var cornerMask = UIRectCorner()
        cornerMask.insert(.topLeft)
        cornerMask.insert(.topRight)
        let path = UIBezierPath(roundedRect: bounds,
                                byRoundingCorners: cornerMask,
                                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        oldViewSize = bounds.size
    }

    public func roundUpperCorners(cornerRadius: CGFloat) {
            guard oldViewSize == nil else {
                return
            }
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = true
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            oldViewSize = bounds.size
    }

    public func roundCorners(cornerRadius: CGFloat = 6.0) {
        layer.cornerRadius = cornerRadius
        layer.masksToBounds = true
    }
}
