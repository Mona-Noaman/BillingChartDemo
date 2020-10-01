//
//  BillingHeaderView.swift
//  VFGMVA10Group
//
//  Created by Samet MACİT on 29.11.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

class BillingHeaderView: UICollectionReusableView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        titleLabel.textColor = .VFGDarkGreyTwoHeader
        detailLabel.textColor = .VFGSecondaryText
    }
}
