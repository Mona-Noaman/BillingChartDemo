//
//  BalanceModel.swift
//  AppCenter-AppCenterDistributeResources
//
//  Created by Samet MACİT on 9.12.2019.
//

import Foundation

// MARK: - BillModel
public protocol BillModelProtocol {
    var bill: Bill { get }
}

public struct BillModel: Codable {
    public var bill: Bill
}

extension BillModel: BillModelProtocol {}

// MARK: - Bill
open class Bill: Codable {
    public var billId: String
    public var amountDue: AmountDue?
    public var paymentDueDate: String
    public var billDocument: BillDocument
    public var remainingAmount: AmountDue
    public var appliedPayment: [AppliedPayment]
    public var relatedParty: RelatedParty
    public var billingAccount: BillingAccount

    public var formattedDueDate: String {
        let month: String = DateHelper.getMonthShortNameFromISO8601Date(
            dateString: paymentDueDate ,
            dateFormatString: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ")
        let day: String = DateHelper.getDayWithSuffixFromISO8601Date(
            dateString: paymentDueDate ,
            dateFormatString: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ")

        let localized = "billing_credit_card_paid_date".localized(bundle: Bundle.mva10Billing)
        return String(format: localized, "\(day)", "", "\(month)")
    }

    public var formattedPaymentDate: String {
        return DateHelper.getFormattedDate(
            paymentDate: appliedPayment.first?.payment.paymentDate ?? "",
            dateFormatString: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
            localizedKey: "billing_dashboard_next_available_date")
    }

    enum CodingKeys: String, CodingKey {
        case billId = "id"
        case amountDue
        case paymentDueDate
        case billDocument
        case remainingAmount
        case appliedPayment
        case relatedParty
        case billingAccount
    }

    public required init (
        billId: String,
        amountDue: AmountDue?,
        paymentDueDate: String,
        billDocument: BillDocument,
        remainingAmount: AmountDue,
        appliedPayment: [AppliedPayment],
        relatedParty: RelatedParty,
        billingAccount: BillingAccount
    ) {
        self.billId = billId
        self.amountDue = amountDue
        self.paymentDueDate = paymentDueDate
        self.billDocument = billDocument
        self.remainingAmount = remainingAmount
        self.appliedPayment = appliedPayment
        self.relatedParty = relatedParty
        self.billingAccount = billingAccount
    }
}

// MARK: - AmountDue
public struct AmountDue: Codable {
    public var value: Double
    public var unit: String

    public init(value: Double, unit: String) {
        self.value = value
        self.unit = unit
    }
    public var localValue: String {
        return "\(String(format: "%.2f", value))\(unit.moneySymbol)"
    }
}

// MARK: - AppliedPayment
public struct AppliedPayment: Codable {
    var payment: Payment
    var appliedAmount: AmountDue?

    init(payment: Payment, appliedAmount: AmountDue?) {
        self.payment = payment
        self.appliedAmount = appliedAmount
    }
}

// MARK: - Payment
public struct Payment: Codable {
    var paymentDate: String
    public init(paymentDate: String) {
        self.paymentDate = paymentDate
    }
}

// MARK: - BillDocument
public struct BillDocument: Codable {
    var url: String

    public init(url: String) {
        self.url = url
    }
}

// MARK: - BillingAccount
public struct BillingAccount: Codable {
    var billingAccountId: String
    enum CodingKeys: String, CodingKey {
        case billingAccountId = "id"
    }

    public init(billingAccountId: String) {
        self.billingAccountId = billingAccountId
    }
}

// MARK: - RelatedParty
public struct RelatedParty: Codable {
    var name: String

    public init(name: String) {
        self.name = name
    }
}
