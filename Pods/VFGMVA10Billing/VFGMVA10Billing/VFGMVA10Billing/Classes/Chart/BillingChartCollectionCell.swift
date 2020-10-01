//
//  BillingChartCell.swift
//  VFGMVA10Group
//
//  Created by Samet MACİT on 29.11.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

public class BillingChartCollectionCell: UICollectionViewCell {

    var chartView: VFGChartView?
    weak var delegate: ChartViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .VFGWhiteBackground
        chartView = VFGChartView.loadXib(bundle: Bundle.mva10Billing)
        guard let chartView = chartView else {
            return
        }
        chartView.frame = self.frame
        contentView.addSubview(chartView)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension BillingChartCollectionCell {
    public func configure(dashboardList: [HistoryModelProtocol]) {
        chartView?.configure(dashboardList: dashboardList)
        chartView?.delegate = delegate
    }
}
