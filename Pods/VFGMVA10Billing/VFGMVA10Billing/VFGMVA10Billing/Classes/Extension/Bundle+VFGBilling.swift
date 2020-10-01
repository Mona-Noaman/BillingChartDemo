//
//  Bundle+VFGBilling.swift
//  VFGMVA10Group
//
//  Created by Samet MACİT on 10.12.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

extension Bundle {
    public static var mva10Billing: Bundle {
        return Bundle(for: DashboardBillingCard.self)
    }
}
