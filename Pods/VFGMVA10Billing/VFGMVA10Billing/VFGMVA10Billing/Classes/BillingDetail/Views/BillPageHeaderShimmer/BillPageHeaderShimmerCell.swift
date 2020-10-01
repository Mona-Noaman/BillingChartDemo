//
//  BillPageHeaderShimmerCell.swift
//  VFGMVA10Billing
//
//  Created by Moustafa Hegazy on 5/13/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit
import VFGFoundation

class BillPageHeaderShimmerCell: UITableViewHeaderFooterView {

    @IBOutlet var shimmerView: [ShimmerView]!

    func startShimmer() {
        for view in shimmerView {
            view.startAnimation()
        }
    }
}
