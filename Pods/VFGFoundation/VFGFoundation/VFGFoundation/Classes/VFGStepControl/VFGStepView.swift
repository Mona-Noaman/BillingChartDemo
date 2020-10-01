//
//  VFGStepView.swift
//  VFGFoundation
//
//  Created by Yahya Saddiq on 8/25/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

class VFGStepView: UIView {
    @IBOutlet weak var pendingImageView: UIImageView!
    @IBOutlet weak var inProgressImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftSeperator: UIView!
    @IBOutlet weak var rightSeperator: UIView!

    var previousStepAction: VFGStepAction = .complete

    private var status: VFGStepStatus = .pending
    private var action: VFGStepAction?
    private static let fontSize: CGFloat = 18.7

    func setup(with title: String, isFirstStep: Bool, isLastStep: Bool) {
        titleLabel.text = title
        updateUI(with: isFirstStep ? .inProgress : .pending)

        leftSeperator.isHidden = isFirstStep
        rightSeperator.isHidden = isLastStep
    }

    func updateUI(with action: VFGStepAction) {
        self.action = action

        switch action {
        case .complete:
            rightSeperator.backgroundColor = .VFGOnboardingSeparatorInProgress

            changeFont(.passed)

            pendingImageView?.backgroundColor = .VFGOnboardingSeparatorInProgress
            pendingImageView?.isHidden = false

            inProgressImageView.isHidden = true

        case .skip:
            rightSeperator.backgroundColor = .VFGOnboardingSeparatorSkipAction

            changeFont(.pending)

            pendingImageView?.backgroundColor = .VFGOnboardingSeparatorSkipAction
            pendingImageView?.isHidden = false

            inProgressImageView.isHidden = true

        case .link:
            rightSeperator.backgroundColor = .VFGOnboardingSeparatorSkipAction
            rightSeperator.isHidden = false

        default:
            break
        }
    }

    func updateUI(with status: VFGStepStatus) {
        self.status = status

        switch status {
        case .pending:
            rightSeperator.backgroundColor = .VFGOnboardingSeparatorSkipAction
            leftSeperator.backgroundColor = .VFGOnboardingSeparatorSkipAction

            pendingImageView?.backgroundColor = .VFGOnboardingSeparatorSkipAction
            pendingImageView?.isHidden = false
            inProgressImageView.isHidden = true

            changeFont(.pending)

        case .inProgress:
            rightSeperator.backgroundColor = .VFGOnboardingSeparatorSkipAction

            if previousStepAction == .complete {
                leftSeperator.backgroundColor = .VFGOnboardingSeparatorInProgress
            } else {
                leftSeperator.backgroundColor = .VFGOnboardingSeparatorSkipAction
            }

            changeFont(.inProgress)

            inProgressImageView.isHidden = false
        case .passed:
            break
        }
    }

    private func changeFont(_ status: VFGStepStatus) {
        switch status {
        case .inProgress:
            titleLabel.font = UIFont.vodafoneBold(VFGStepView.fontSize)
            titleLabel.textColor = .VFGPrimaryText
        case .pending:
            titleLabel.font = UIFont.vodafoneRegular(VFGStepView.fontSize)
            titleLabel.textColor = .VFGSecondaryText
        case .passed:
            titleLabel.font = UIFont.vodafoneRegular(VFGStepView.fontSize)
            titleLabel.textColor = .VFGPrimaryText
        }
    }
}
