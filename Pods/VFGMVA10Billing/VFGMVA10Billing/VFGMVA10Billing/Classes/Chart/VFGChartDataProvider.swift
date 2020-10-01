//
//  VFGChartDataProvider.swift
//  VFGMVA10Billing
//
//  Created by Hussein Kishk on 5/19/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

class VFGChartDataProvider {

    var barData: [Bar] = []
    var maxBarHeightValue = 0.0

    func populateChartData(dashboardList: [HistoryModelProtocol],
                           priceFormat: String,
                           minBarsToBeViewed: Int,
                           completion: @escaping () -> Void ) {
        barData.removeAll(keepingCapacity: true)
        var newBarData: [Bar] = []
        guard let firstBill = dashboardList.first else {
            completion()
            return
        }
        var barsToBeViewed = 0
        if dashboardList.count >= VFGMVA10BillingConstants.monthsInTwoYears {
            barsToBeViewed = VFGMVA10BillingConstants.monthsInTwoYears
        } else if dashboardList.count >= 12 {
            barsToBeViewed = dashboardList.count
        } else {
            barsToBeViewed = minBarsToBeViewed == 0 ?
                (VFGMVA10BillingConstants.monthsInTwoYears / 2) : minBarsToBeViewed
        }
        for index in 0..<barsToBeViewed {
            if index < dashboardList.count {
                let item = dashboardList[index]
                updateMaxBarHeight(with: item.amountDue?.value ?? 0.0)
                newBarData.append(Bar(title: getShortMonth(item.billMonth),
                                      value: item.amountDue?.value ?? 0.0,
                                      info: String(format: priceFormat,
                                                   arguments: [String(format: "%.2f", item.amountDue?.value ?? 0.0),
                                                               "\(item.amountDue?.unit.moneySymbol ?? "")"]),
                                      startDateTime: item.billingPeriod?.startDateTime ?? "",
                                      endDateTime: item.billingPeriod?.endDateTime ?? "",
                                      billDateInterval: item.billDateInterval,
                                      billMonthID: item.billMonthId,
                                      billYear: item.billYear))
            } else {
                if let currentDate = Calendar.current.date(byAdding: .month, value: index * -1, to:
                    DateHelper.getDateFromString(dateString: firstBill.billDate) ?? Date()) {
                    let month = DateHelper.getMonthShortNameFromISO8601Date(dateString:
                        DateHelper.getStringFromDate(date: currentDate))
                    newBarData.append(Bar(title: month, value: 0, info: ""))
                }
            }
        }
        barData = newBarData.reversed()
        completion()
    }

    func updateMaxBarHeight(with value: Double) {
        if value > maxBarHeightValue {
            maxBarHeightValue = value
        }
    }

    func getShortMonth(_ month: String) -> String {
        let range = month.startIndex..<month.index(month.startIndex, offsetBy: 3)
        return String(month[range])
    }
}
