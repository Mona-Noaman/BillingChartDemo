//
//  ChartShimmerCell.swift
//  VFGMVA10Billing
//
//  Created by Moustafa Hegazy on 5/10/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit
import VFGFoundation

class ChartShimmerCell: UICollectionViewCell {

    @IBOutlet var shimmerView: ShimmerView!
    func configureCell() {
        shimmerView.startAnimation()
    }
}
