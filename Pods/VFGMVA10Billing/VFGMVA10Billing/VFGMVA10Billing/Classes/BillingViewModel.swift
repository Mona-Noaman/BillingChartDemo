//
//  BilllingCardViewModel.swift
//  VFGMVA10Group
//
//  Created by Samet MACİT on 6.12.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

public final class BillingViewModel: BillingViewModelProtocol {
    weak public var delegate: BillingViewModelDelegate?
    private let dataProvider: VFGBillingDataProviderProtocol
    private var historyList: [HistoryModelProtocol] = []
    private var dashboardList: [DashboardModelProtocol] = []

    public init(dataProvider: VFGBillingDataProviderProtocol) {
        self.dataProvider = dataProvider
        setup()
    }

    public func setup() {}

    public func loadHistoryData() {
        notify(.shimmerChart)
        notify(.shimmerPreviousAndCurrent)
        dataProvider.fetchHistoryData { [weak self] (result, error) in
            guard let self = self, error == nil else { return }
            guard let historyBills = result?.reversed() else { return }
            self.notify(.updateBills(current: result?.last, pre: Array((historyBills.dropFirst()))))
        }
    }

    public func loadBalanceData() {
        dataProvider.fetchBalanceData { [weak self] (result, error) in
            guard let self = self else { return }
            guard error == nil else {
                return
            }
            self.notify(.updateBalance(result))
        }
    }

    private func notify(_ output: BillingViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
