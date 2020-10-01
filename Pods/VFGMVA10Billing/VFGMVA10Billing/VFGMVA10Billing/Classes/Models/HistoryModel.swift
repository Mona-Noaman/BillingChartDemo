//
//  History.swift
//  VFGMVA10Group
//
//  Created by Samet MACİT on 25.11.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//
import Foundation

// MARK: - History
public struct HistoryModel: Codable {
    public var amountDue: AmountDue?
    public var outOfBundleAmount: [OutOfBundleAmount]
    public var historyId: String
    public var billDate: String
    public var paymentMethod: PaymentMethod?
    public var state: String?
    public var remainingAmount: AmountDue?
    public var billingPeriod: BillingPeriod?

    public init(amountDue: AmountDue?,
                outOfBundleAmount: [OutOfBundleAmount],
                historyId: String,
                billDate: String,
                paymentMethod: PaymentMethod?,
                state: String?,
                remainingAmount: AmountDue?,
                billingPeriod: BillingPeriod?) {
        self.amountDue = amountDue
        self.outOfBundleAmount = outOfBundleAmount
        self.historyId = historyId
        self.billDate = billDate
        self.paymentMethod = paymentMethod
        self.state = state
        self.remainingAmount = remainingAmount
        self.billingPeriod = billingPeriod
    }

    enum CodingKeys: String, CodingKey {
        case amountDue
        case outOfBundleAmount
        case historyId = "id"
        case billDate
        case paymentMethod
        case state
        case remainingAmount
        case billingPeriod
    }
}

// MARK: - BillingPeriod
public struct BillingPeriod: Codable {
    var startDateTime, endDateTime: String
    public init(startDateTime: String, endDateTime: String) {
        self.startDateTime = startDateTime
        self.endDateTime = endDateTime
    }
}

// MARK: - OutOfBundleAmount
public struct OutOfBundleAmount: Codable {
    var value: Double
    var unit: String
    var date: String?
    var characteristic: [Characteristic]
    public init(value: Double, unit: String, date: String?, characteristic: [Characteristic]) {
        self.value = value
        self.unit = unit
        self.date = date
        self.characteristic = characteristic
    }

    var localValue: String {
        return "\(value)\(unit.moneySymbol)"
    }
}

// MARK: - Characteristic
public struct Characteristic: Codable {
    var name: Name
    var value: String
    public init(name: Name, value: String) {
        self.name = name
        self.value = value
    }
}

public enum Name: String, Codable {
	case description = "Description"
	case destinationSubscription = "DestinationSubscription"
	case amount = "Amount"
    case serviceType = "ServiceType"
    case usageUnit = "UsageUnit"
    case usageValue = "UsageValue"
    case msisdn = "MSISDN"
    case originalSubscription = "originalSubscription"
    case dataService = "DataService"
}

// MARK: - PaymentMethod
public struct PaymentMethod: Codable {
    var paymentMethodId: String
    var referredType, brand, lastFourDigits: String?
    public init(paymentMethodId: String, referredType: String?, brand: String?, lastFourDigits: String?) {
        self.paymentMethodId = paymentMethodId
        self.referredType = referredType
        self.brand = brand
        self.lastFourDigits = lastFourDigits
    }

    enum CodingKeys: String, CodingKey {
        case paymentMethodId = "id"
        case referredType
        case brand
        case lastFourDigits
    }
}

extension HistoryModel: HistoryModelProtocol {}
