//
//  VFGBillsViewController+ShowMoreLogic.swift
//  VFGMVA10Billing
//
//  Created by Moustafa Hegazy on 5/5/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

extension VFGBillsViewController {

    func numberOfRowsIfShowMorePressed(_ recentBillsCount: Int) -> Int {
        if showMorePressed {
            preMonthsCount = 12
            if (recentBillsCount - monthsCounter) > preMonthsCount {
                monthsCounter += preMonthsCount
                return monthsCounter
            }
            monthsCounter = 0
            return recentBillsCount
        } else {
            monthsCounter = preMonthsCount
            return preMonthsCount
        }
    }

    func numberOfRowsInSecondSection(recentBillsCount: Int) -> Int {
        var rowsCount = 0
        if recentBillsCount == 0 &&
            startPreviousAndCurrentShimmerAnimation {
            rowsCount = 1
        } else if shouldShowRecentBills(recentBillsCount) {
            rowsCount = numberOfRowsIfShowMorePressed(recentBillsCount)
        } else {
            rowsCount = recentBillsCount
        }
        return rowsCount
    }

    func shouldShowRecentBills(_ recentBillsCount: Int) -> Bool {
        return recentBillsCount > preMonthsCount
    }

    func numberOfRowsInThirdSection(recentBillsCount: Int) -> Int {
        let countAccordingToMonths = (monthsCounter == 0) ? 0 : 1
        if shouldShowRecentBills(recentBillsCount) {
            return showMorePressed ? countAccordingToMonths : 1
        } else {
            return 0
        }
    }
}
