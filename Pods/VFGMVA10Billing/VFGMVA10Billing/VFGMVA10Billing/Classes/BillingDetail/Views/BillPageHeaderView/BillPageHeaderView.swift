//
//  BillPageHeaderView.swift
//  VFGBilling
//
//  Created by Mert Karabulut on 16.12.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit
import VFGFoundation

protocol BillPageHeaderViewDelegate: class {
	func backButtonPressed()
	func closeButtonPressed()
}

class BillPageHeaderView: UITableViewHeaderFooterView {
	weak var delegate: BillPageHeaderViewDelegate?

	@IBOutlet weak var labelBillTitle: VFGLabel!
	@IBOutlet weak var labelBillingPeriod: VFGLabel!
	@IBOutlet weak var labelAmount: VFGLabel!

	override func awakeFromNib() {
		super.awakeFromNib()
		labelBillTitle.translatesAutoresizingMaskIntoConstraints = false
		labelBillingPeriod.translatesAutoresizingMaskIntoConstraints = false
		labelAmount.translatesAutoresizingMaskIntoConstraints = false
		labelBillTitle.text = ""
		labelBillingPeriod.text = ""
		labelAmount.text = ""
	}

	// MARK: - Actions
	@IBAction func backButtonPressed(_ sender: UIButton) {
		if let delegate = delegate {
			delegate.backButtonPressed()
		}
	}
	@IBAction func closeButtonPressed(_ sender: UIButton) {
		if let delegate = delegate {
			delegate.closeButtonPressed()
		}
	}
}

extension BillPageHeaderView {
	final func configure(bill: BillDetailModelProtocol) {
		let localized = "billing_details_title".localized(bundle: Bundle.mva10Billing)
		let localizedString = String(format: localized, "\(bill.billMonth)")
		labelBillTitle.text = localizedString
		labelBillingPeriod.text = bill.billStartEndDate
		labelAmount.text = bill.amountDue.localValue
	}
}
