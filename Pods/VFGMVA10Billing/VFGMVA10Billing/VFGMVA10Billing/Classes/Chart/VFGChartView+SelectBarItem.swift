//
//  VFGChartView+ConfigureUI.swift
//  VFGMVA10Billing
//
//  Created by Moustafa Hegazy on 8/25/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

extension VFGChartView {
    public func selectBarItem(row: Int) {
        if !isFirstDraw {
            let barDataCount = self.dataProvider?.barData.count ?? 0
            let selectedIndexRow = (barDataCount - 1) - row
            let indexPath = IndexPath(item: selectedIndexRow, section: 0)
            if barDataCount > row {
                chartCollectionView.scrollToItemIfValid(at: IndexPath(item: indexPath.row, section: 0),
                                                        at: .left, animated: true, completion: {
                                                            self.collectionView(self.chartCollectionView,
                                                                                didSelectItemAt: indexPath)
                })
            }
        } else {
            firstDrawSelectedIndex = row
            isFirstDraw = false
        }
    }
}
