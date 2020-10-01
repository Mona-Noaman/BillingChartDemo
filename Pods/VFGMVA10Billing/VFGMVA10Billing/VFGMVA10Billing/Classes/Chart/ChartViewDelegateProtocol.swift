//
//  ChartViewDelegateProtocol.swift
//  VFGMVA10Billing
//
//  Created by Hussein Kishk on 8/16/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public protocol ChartViewDelegate: class {
    func seeBillButtonPressed(selectedRowInRecentBills: Int)
    func didSelectBillAt(row: Int)
    func didDeselectBillAt(row: Int)
    var billingPeriodFormat: BillingPeriodFormat { get }
}

extension ChartViewDelegate {
    public func didSelectBillAt(row: Int) { }
    public func didDeselectBillAt(row: Int) { }
}
