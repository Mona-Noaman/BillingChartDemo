//
//  BillSummaryCell.swift
//  VFGBilling
//
//  Created by Mert Karabulut on 16.12.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit
import VFGFoundation

class BillSummaryCell: UITableViewCell {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var labelClientCode: VFGLabel!
    @IBOutlet weak var labelClientCodeValue: VFGLabel!
    @IBOutlet weak var labelBillNumber: VFGLabel!
    @IBOutlet weak var labelClientNumberValue: VFGLabel!
    @IBOutlet weak var labelPaymentMethod: VFGLabel!
    @IBOutlet weak var labelPaymentMethodValue: VFGLabel!
    @IBOutlet weak var buttonPay: VFGButton!
    @IBOutlet var badgeView: UIView!
    @IBOutlet var badgeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        viewContainer.configureShadow()
        labelClientCode.text = "billing_client_code".localized(bundle: Bundle.mva10Billing)
        labelClientCodeValue.text = ""
        labelBillNumber.text = "billing_bill_number".localized(bundle: Bundle.mva10Billing)
        labelClientNumberValue.text = ""
        labelPaymentMethod.text = "billing_payment_method".localized(bundle: Bundle.mva10Billing)
        labelPaymentMethodValue.text = ""
    }
}

extension BillSummaryCell {
    final func configure(billPayment: BillAppliedPayment,
                         billId: String,
                         partyAccountId: String,
                         actionButtonType: ActionButtonType?) {
        labelClientCodeValue.text = partyAccountId
        labelClientNumberValue.text = billId
        setupActionButton(billPayment: billPayment, actionButtonType: actionButtonType)
        if let paymentDetails = billPayment.payment?.paymentMethod?.details {
            if let brand = paymentDetails.brand, let lastFourdigits = paymentDetails.lastFourdigits {
                let localized = "billing_credit_card_stars".localized(bundle: Bundle.mva10Billing)
                let localizedString = String(format: localized, "\(brand)", "\(lastFourdigits)")
                labelPaymentMethodValue.text = localizedString
            }
        }
    }

    func setupActionButton(billPayment: BillAppliedPayment, actionButtonType: ActionButtonType?) {
        switch actionButtonType {
        case .paid:
            badgeView.isHidden = false
            buttonPay.isHidden = true
            badgeLabel.text = billPayment.payment?.paidBillPaymentDateText
        case .toBePaid:
            badgeView.isHidden = true
            buttonPay.isHidden = false
            buttonPay.isEnabled = false
            buttonPay.setTitle(billPayment.payment?.toBeBillPaymentDateText, for: .normal)
        default:
            buttonPay.isEnabled = false
        }
    }
}
