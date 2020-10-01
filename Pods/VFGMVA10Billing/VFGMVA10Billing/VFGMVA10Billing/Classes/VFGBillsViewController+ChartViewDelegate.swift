//
//  VFGBillsViewController+ChartViewDelegate.swift
//  VFGMVA10Billing
//
//  Created by Hussein Kishk on 6/3/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

extension VFGBillsViewController: ChartViewDelegate {

    public var billingPeriodFormat: BillingPeriodFormat {
        return .custom(format: "dd MMM")
    }

    public func seeBillButtonPressed(selectedRowInRecentBills selectedRow: Int) {
        guard !recentBills.isEmpty, let currentBill = currentBill else { return }
        var totalBills = recentBills
        totalBills.insert(currentBill, at: 0)
        // MARK: Here to check bill status from graph
        setupDetailsView(selectedBill: totalBills[selectedRow], actionButtonType: selectedRow > 0 ? .paid : .toBePaid)
    }
}
