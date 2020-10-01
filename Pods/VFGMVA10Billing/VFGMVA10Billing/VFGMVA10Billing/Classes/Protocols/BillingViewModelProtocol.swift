//
//  BillingItemViewModelProtocol.swift
//  VFGMVA10Group
//
//  Created by Samet MACİT on 6.12.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

public protocol BillingViewModelProtocol {
    var delegate: BillingViewModelDelegate? { get set }
    func setup()
    func loadHistoryData()
    func loadBalanceData()
}

public enum BillingViewModelOutput {
    case updateBills(current: HistoryModelProtocol?, pre: [HistoryModelProtocol]?)
    case updateBalance(BillModelProtocol?)
    case shimmerPreviousAndCurrent
    case shimmerChart
}

public protocol BillingViewModelDelegate: class {
    func handleViewModelOutput(_ output: BillingViewModelOutput)
}
