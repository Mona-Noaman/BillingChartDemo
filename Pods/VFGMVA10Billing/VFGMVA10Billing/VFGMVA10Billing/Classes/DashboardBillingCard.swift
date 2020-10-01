//
//  DashboardBillingCard.swift
//  VFGMVA10Group
//
//  Created by Samet MACİT on 25.11.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//
import UIKit
import Foundation
import VFGFoundation

class DashboardBillingCard: UIView {
    @IBOutlet weak var labelSpending: UILabel!
    @IBOutlet weak var labelPayDate: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var descriptionIcon: UIImageView!
    @IBOutlet var noBillDate: UILabel!
    var errorCard: ErrorCard?
    var accessibilityIdInitial: String? {
        didSet {
            accessibilityIdentifier = accessibilityIdInitial
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        localizeTitleLabel()
    }

    fileprivate func localizeTitleLabel() {
        titleLabel.text = "billing_dashboard_title".localized(bundle: Bundle.mva10Billing)
    }

    fileprivate func setupLabels(model: Bill) {
        guard let amount = model.amountDue?.value else {
            return
        }
        labelSpending.text = model.amountDue?.localValue
        labelSpending.textColor = amount >= 0.0 ? .VFGPrimaryText : .VFGRedOrangeText
        labelPayDate.text = model.formattedDueDate
        descriptionLabel.text = "billing_dashboard_description".localized(bundle: Bundle.mva10Billing)
    }

    fileprivate func setupNoBillLabels(model: Bill) {
        noBillDate.text = model.formattedPaymentDate
    }

    func configure(model: Bill?) {
        if let model = model {
            let billAmountDue = model.amountDue?.value
            if billAmountDue == nil {
                setupNoBillLabels(model: model)
                showNoBillIcon()
            } else {
                setupLabels(model: model)
                hideNoBillIcon()
            }
        }
    }

    func showErrorMessage(errorMessage: String?) {
        errorCard = ErrorCard.loadXib(bundle: Bundle.foundation)
        errorCard?.configure(errorMessage: errorMessage,
                             accessibilityIdInitial: accessibilityIdInitial)
        errorCard?.frame = bounds
        self.addSubview(errorCard ?? UIView())
    }

    fileprivate func showNoBillIcon() {
        descriptionIcon.isHidden = false
        noBillDate.isHidden = false
        labelSpending.isHidden = true
        labelPayDate.isHidden = true
        descriptionLabel.isHidden = true
    }

    fileprivate func hideNoBillIcon() {
        descriptionIcon.isHidden = true
        noBillDate.isHidden = true
        labelSpending.isHidden = false
        labelPayDate.isHidden = false
        descriptionLabel.isHidden = false
    }
}
