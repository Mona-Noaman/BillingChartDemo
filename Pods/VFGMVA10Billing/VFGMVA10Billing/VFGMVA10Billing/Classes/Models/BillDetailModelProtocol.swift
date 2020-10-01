//
//  BillDetailModelProtocol.swift
//  VFGMVA10Billing
//
//  Created by Salma Ashour on 9/7/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public protocol BillDetailModelProtocol {
    var amountDue: AmountDue { get }
    var billId: String { get }
    var billDate: String? { get }
    var subscription: [Subscription]? { get }
    var relatedParty: RelatedParty { get }
    var billingAccount: Account { get }
    var remainingAmount: AmountDue? { get }
    var billingPeriod: BillingPeriod? { get }
    var billDocument: BillDocument? { get }
    var partyAccount: Account? { get }
    var appliedPayment: [BillAppliedPayment]? { get }
}

// MARK: - Extensions
public extension BillDetailModelProtocol {
    var billMonth: String {
        return DateHelper.getMonthFromISO8601Date(dateString: billDate ?? "",
                                                  dateFormatString: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ")
    }

    var billStartEndDate: String {
        return DateHelper.getDateIntervalFromISO8601Date(startDate: billingPeriod?.startDateTime ?? "",
                                                         endDate: billingPeriod?.endDateTime ?? "",
                                                         dateFormatString: "yyyy-MM-dd'T'HH:mm:ssZZZZZ")
    }
}
