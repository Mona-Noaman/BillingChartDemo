//
//  VFGChartView+TraitChange.swift
//  VFGMVA10Billing
//
//  Created by Hussien Gamal Mohammed on 7/19/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

extension VFGChartView {
    public override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                let lastBarRow = (dataProvider?.barData.count ?? 0) - 1
                updateLastBarIfSelected(lastBarRow: lastBarRow)
            }
        }
    }

    func updateBorderColorForLastBar(_ row: Int,
                                     _ cell: ChartBarCell) {
        if selectedIndexPath?.row == row {
            cell.barView.layer.borderColor = cgColor(of: UIColor.VFGChartBarsActive,
                                                     with: traitCollection)
        } else {
            cell.barView.layer.borderColor = cgColor(of: unselectedBarsColor,
                                                     with: traitCollection)
        }
    }

    func updateLastBarIfSelected(lastBarRow: Int) {
        if #available(iOS 13.0, *) {
            let lastBarIndexPath = IndexPath(item: lastBarRow,
                                             section: 0)
            guard let cell = chartCollectionView.cellForItem(at: lastBarIndexPath) as? ChartBarCell else {
                return
            }
            updateBorderColorForLastBar(lastBarRow, cell)
        }
    }

     func cgColor(of color: UIColor, with traitCollection: UITraitCollection) -> CGColor {
        if #available(iOS 13.0, *) {
            return color.resolvedColor(with: traitCollection).cgColor
        } else {
            return color.cgColor
        }
    }
}
