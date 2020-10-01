//
//  BillCostView.swift
//  VFGBilling
//
//  Created by Mert Karabulut on 17.12.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit
import VFGFoundation

class BillCostView: UIView {

	@IBOutlet weak var labelServiceCost: VFGLabel!
	@IBOutlet weak var labelServiceCostValue: VFGLabel!

	override func awakeFromNib() {
		super.awakeFromNib()
	}
}

extension BillCostView {
	final func configure(billDetailItem: BillDetailItemModelProtocol) {
		labelServiceCost.text = billDetailItem.description
		labelServiceCostValue.text = billDetailItem.amount ?? ""
	}
}
