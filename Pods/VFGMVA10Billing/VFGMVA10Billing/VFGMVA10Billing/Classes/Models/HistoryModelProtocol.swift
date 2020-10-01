//
//  HistoryModelProtocol.swift
//  VFGMVA10Billing
//
//  Created by Salma Ashour on 8/23/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public protocol HistoryModelProtocol {
    var amountDue: AmountDue? { get }
    var outOfBundleAmount: [OutOfBundleAmount] { get }
    var historyId: String { get }
    var billDate: String { get }
    var paymentMethod: PaymentMethod? { get }
    var state: String? { get }
    var remainingAmount: AmountDue? { get }
    var billingPeriod: BillingPeriod? { get }
}

public extension HistoryModelProtocol {
    var billYear: String {
        return DateHelper.getYearFromISO8601Date(dateString: billDate)
    }

    var billMonth: String {
        return DateHelper.getMonthFromISO8601Date(dateString: billDate)
    }

    var billMonthId: Int {
        return DateHelper.getMonthIdFromISO8601Date(dateString: billDate)
    }

    var billDateInterval: String {
        return DateHelper.getDateIntervalFromISO8601Date(
            startDate: billingPeriod?.startDateTime ?? "",
            endDate: billingPeriod?.endDateTime ?? "")
    }
}
