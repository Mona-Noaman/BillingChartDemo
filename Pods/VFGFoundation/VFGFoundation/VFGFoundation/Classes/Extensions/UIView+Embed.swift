//
//  UIView+Embed.swift
//  VFGMVA10Group
//
//  Created by Sandra Morcos on 6/16/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

extension UIView {
    public func embed(view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        addConstraints(view: view)
    }
}

private extension UIView {
    func addConstraints(view: UIView) {
        let topConstraint = NSLayoutConstraint(item: view,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: self,
                                               attribute: .top,
                                               multiplier: 1,
                                               constant: 0)
        let bottomConstraint = NSLayoutConstraint(item: view,
                                                  attribute: .bottom,
                                                  relatedBy: .equal,
                                                  toItem: self,
                                                  attribute: .bottom,
                                                  multiplier: 1,
                                                  constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: view,
                                                   attribute: .leading,
                                                   relatedBy: .equal,
                                                   toItem: self,
                                                   attribute: .leading,
                                                   multiplier: 1,
                                                   constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: view,
                                                    attribute: .trailing,
                                                    relatedBy: .equal,
                                                    toItem: self,
                                                    attribute: .trailing,
                                                    multiplier: 1,
                                                    constant: 0)

        NSLayoutConstraint.activate([topConstraint, bottomConstraint, leadingConstraint, trailingConstraint])
        view.updateConstraints()
    }
}
