//
//  BillServiceItemView.swift
//  VFGBilling
//
//  Created by Mert Karabulut on 17.12.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit
import VFGFoundation

class BillServiceItemView: UIView {
    @IBOutlet weak var imageViewServiceItem: UIImageView!
    @IBOutlet weak var labelServiceItem: VFGLabel!
    @IBOutlet weak var labelServiceItemValue: VFGLabel!
}

extension BillServiceItemView {
    final func configure(billDetailItem: BillDetailItemModelProtocol) {
        if let imageName = billDetailItem.imageName {
            imageViewServiceItem.tintColor = .VFGGreyTint
            imageViewServiceItem.image = UIImage(named: imageName, in: Bundle.mva10Billing, compatibleWith: nil)
        }

        labelServiceItem.text = billDetailItem.description

        if let amount = billDetailItem.amount {
            labelServiceItemValue.text = amount
            labelServiceItemValue.isHidden = false
        } else {
            labelServiceItemValue.isHidden = true
        }
    }
}
