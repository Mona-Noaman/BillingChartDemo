//
//  UIStackView+Helper.swift
//  VFGBilling
//
//  Created by Mert Karabulut on 24.12.2019.
//

import UIKit

public extension UIStackView {

	func removeAllArrangedSubviews() {

        let removedSubviews = arrangedSubviews.reduce([]) { (allSubviews, subview) -> [UIView] in
            self.removeArrangedSubview(subview)
            return allSubviews + [subview]
        }

        removedSubviews.forEach({ $0.removeFromSuperview() })
    }
}
