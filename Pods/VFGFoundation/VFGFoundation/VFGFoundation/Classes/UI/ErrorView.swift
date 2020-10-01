//
//  ErrorView.swift
//  VFGFoundation
//
//  Created by Yahya Saddiq on 7/1/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

open class ErrorView: UIView {
    @IBOutlet public weak var errorImageView: UIImageView!
    @IBOutlet public weak var errorMessageLabel: UILabel!
    @IBOutlet public weak var tryAgainLabel: UILabel!
    @IBOutlet public weak var refreshImage: UIImageView!

    public func configure(errorMessage: String?,
                          accessibilityIdInitial: String? = nil) {
        guard let errorMessage = errorMessage,
            !errorMessage.isEmpty else {
            return
        }

        errorMessageLabel.text = errorMessage
        setupAccessibilityIds(accessibilityIdInitial)
    }

    open func setupAccessibilityIds(_ accessibilityIdInitial: String?) {
        guard var accessibilityIdInitial = accessibilityIdInitial else {
            return
        }

        if !accessibilityIdInitial.contains("error") {
            accessibilityIdInitial += "Error"
        }

        errorMessageLabel.accessibilityIdentifier = accessibilityIdInitial + "Description"
        errorImageView.accessibilityIdentifier = accessibilityIdInitial + "Icon"
        tryAgainLabel.accessibilityIdentifier = accessibilityIdInitial + "TryAgainText"
        refreshImage.accessibilityIdentifier = accessibilityIdInitial + "Arrow"
    }
}
