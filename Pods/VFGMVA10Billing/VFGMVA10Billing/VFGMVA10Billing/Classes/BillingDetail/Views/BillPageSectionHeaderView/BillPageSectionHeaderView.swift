//
//  BillPageSectionHeaderView.swift
//  VFGBilling
//
//  Created by Mert Karabulut on 17.12.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit
import VFGFoundation

class BillPageSectionHeaderView: UITableViewHeaderFooterView {

	@IBOutlet weak var labelTitle: VFGLabel!

    override func awakeFromNib() {
		super.awakeFromNib()
		labelTitle.translatesAutoresizingMaskIntoConstraints = false
		labelTitle.text = "billing_payment_breakdown_title".localized(bundle: Bundle.mva10Billing)
	}
}
