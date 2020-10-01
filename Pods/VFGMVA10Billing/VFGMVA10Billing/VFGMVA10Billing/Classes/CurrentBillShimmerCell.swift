//
//  CurrentBillShimmerCell.swift
//  VFGMVA10Billing
//
//  Created by Moustafa Hegazy on 5/7/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit
import VFGFoundation
class CurrentBillShimmerCell: UICollectionViewCell {
    @IBOutlet var allShimmerViews: [ShimmerView]!
    func startShimmer() {
        allShimmerViews.forEach { (shimmerdView) in
            shimmerdView.startAnimation()
        }
    }
}
