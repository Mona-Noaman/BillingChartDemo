//
//  MVA10NavigationView.swift
//  VFGFoundation
//
//  Created by Mohamed Abd ElNasser on 12/10/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

class MVA10NavigationView: UIView {

    @IBOutlet weak var bottomDivider: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    var hasDivider = true {
        didSet {
            self.bottomDivider.alpha = hasDivider ? 1: 0
        }
    }
    var isTranslucent = false {
        didSet {
            self.backgroundColor = isTranslucent ? .clear: .VFGWhiteBackground
        }
    }
    func setTitle(title: String, accessibilityIdentifier: String = "") {
        let attributes = [NSAttributedString.Key.font: UIFont.vodafoneRegular(19.0),
                          .foregroundColor: UIColor.VFGPrimaryText]
        let attrString = NSAttributedString(string: title, attributes: attributes)

        titleLabel.attributedText = attrString
        titleLabel.accessibilityIdentifier = accessibilityIdentifier
    }

    func setAccessibilityIDs(closeButtonID: String = "", backButtonID: String = "") {
        closeButton.accessibilityIdentifier = closeButtonID
        backButton.accessibilityIdentifier = backButtonID
    }
}
