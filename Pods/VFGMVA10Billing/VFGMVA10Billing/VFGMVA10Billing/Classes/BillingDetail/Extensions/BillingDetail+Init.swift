//
//  BillingDetail+Init.swift
//  VFGBilling
//
//  Created by Mert Karabulut on 19.12.2019.
//

import Foundation
import UIKit

public extension BillingDetailViewController {
    class func instance() -> BillingDetailViewController {
        return BillingDetailViewController.instance(from: "Billing",
                                                    bundle: Bundle.mva10Billing)
    }
}
