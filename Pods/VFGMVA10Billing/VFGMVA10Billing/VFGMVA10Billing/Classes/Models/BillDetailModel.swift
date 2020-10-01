//
//  BillDetailModel.swift
//  VFGBilling
//
//  Created by Mert Karabulut on 19.12.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//
import Foundation

// MARK: - BillDetailModel
public struct BillDetailModel: Codable {
    public var amountDue: AmountDue
    public var billId: String
    public var billDate: String?
    public var subscription: [Subscription]?
    public var relatedParty: RelatedParty
    public var billingAccount: Account
    public var remainingAmount: AmountDue?
    public var billingPeriod: BillingPeriod?
    public var billDocument: BillDocument?
    public var partyAccount: Account?
    public var appliedPayment: [BillAppliedPayment]?

    enum CodingKeys: String, CodingKey {
        case billId = "id"
        case amountDue, billDate, subscription
        case relatedParty, billingAccount, remainingAmount
        case billingPeriod, billDocument, partyAccount, appliedPayment
    }
}

extension BillDetailModel: BillDetailModelProtocol {}

// MARK: - BillAppliedPayment
public struct BillAppliedPayment: Codable {
    public var payment: BillPayment?
}

// MARK: - BillPayment
public struct BillPayment: Codable {
    var paymentId, baseType: String?
    var schemaLocation: String?
    var type, referredType: String?
    var amount: AmountDue?
    var paymentDate: String?
    var paymentMethod: BillPaymentMethod?

    enum CodingKeys: String, CodingKey {
        case paymentId = "id"
        case baseType = "baseType"
        case schemaLocation
        case type = "type"
        case referredType = "referredType"
        case amount, paymentDate, paymentMethod
    }
}

// MARK: - BillPaymentMethod
public struct BillPaymentMethod: Codable {
    var paymentMethodId, type: String?
    var details: Details?

    enum CodingKeys: String, CodingKey {
        case paymentMethodId = "id"
        case type = "type"
        case details
    }
}

// MARK: - Details
public struct Details: Codable {
    var brand, lastFourdigits: String?
}

// MARK: - Account
public struct Account: Codable {
    var accountId: String?

    enum CodingKeys: String, CodingKey {
        case accountId = "id"
    }
}

// MARK: - Subscription
public struct Subscription: Codable {
    var productTerm: ProductTerm?
    var name: String
    var isBundle: Bool?
    var relatedParty: RelatedParty?
    var outOfBundleAmount: [OutOfBundleAmount]?
    var otherChargesAmount: AmountDue?
    var productCharacteristic: [[Characteristic]]?
    var totalBeforeVAT, totalVAT: AmountDue?
    var isExpanded: Bool? = false
}

// MARK: - ProductTerm
public struct ProductTerm: Codable {
    var amount: Int
    var units: String
}

public extension BillingPeriod {
    var billingPeriod: String {
        return DateHelper.getDateIntervalFromISO8601Date(startDate: startDateTime,
                                                         endDate: endDateTime)
    }
}

public extension OutOfBundleAmount {
	var bundleDescription: String {
		var description: String = ""
		for characteristicItem in characteristic where characteristicItem.name == .description {
				description = characteristicItem.value
				break
		}
		return description
	}

	var nonBundleDescription: String {
		var description: String = ""
		var serviceType: Characteristic?
		var destinationSubscription: Characteristic?
		for characteristicItem in characteristic {
			if characteristicItem.name == .serviceType {
				serviceType = characteristicItem
			} else if characteristicItem.name == .destinationSubscription {
				destinationSubscription = characteristicItem
			}
		}
		if let service = serviceType, let destination = destinationSubscription {
			let destinationAction: String
			if service.value == "Voice" {
				destinationAction = "billing_details_call_to".localized(bundle: Bundle.mva10Billing)
			} else {
				destinationAction = service.value
			}
			description = "\(destinationAction) \(destination.value)"
		}
		return description
	}
}

public extension BillPayment {
	var toBeBillPaymentDateText: String {
        let month: String = DateHelper.getMonthFromISO8601Date(dateString: paymentDate ?? "",
															   dateFormatString: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ")
        let day: String = DateHelper.getDayWithSuffixFromISO8601Date(dateString: paymentDate ?? "",
																	 dateFormatString: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ")

		let localized = "billing_dashboard_due_date_args".localized(bundle: Bundle.mva10Billing)
		let localizedString = String(format: localized, "\(day)", "", "\(month)")

		return localizedString
	}
    var paidBillPaymentDateText: String {
        let date: String = DateHelper.changeDateStringFormat(dateString: paymentDate ?? "",
                                                             format: "dd.MM.yyyy",
                                                             dateFormatString: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ") ?? ""
        let localized = "billing_credit_card_already_paid".localized(bundle: Bundle.mva10Billing)
        let localizedString = String(format: localized, "\(date)")
        return localizedString
    }
}

public extension Subscription {
	var outOfAmounts: [BillDetailItemModelProtocol]? {
		var list: [BillDetailItemModelProtocol] = []
		if let outOfBundleList = outOfBundleAmount {
			for outOfBundleItem in outOfBundleList {
				let detailItem = BillDetailItemModel(imageName: nil,
                                                     description: (isBundle == true) ?
                                                        outOfBundleItem.bundleDescription :
                                                        outOfBundleItem.nonBundleDescription,
                                                     amount: outOfBundleItem.localValue,
													 date: outOfBundleItem.date)
				list.append(detailItem)
			}
		}

		return list
	}

	var products: [BillDetailItemModelProtocol]? {
		var list: [BillDetailItemModelProtocol] = []

		if let productCharacteristicList = productCharacteristic {
			for productList in productCharacteristicList {
				if isBundle == true, productList.count == 2 {
					var imageName: String?
					var description: String = ""
					for characteristicItem in productList {
						if characteristicItem.name == .serviceType {
							if characteristicItem.value == "Broadband" {
								imageName = "icWifiBroadband"
							} else if characteristicItem.value == "TV" {
								imageName = "icTv"
							} else if characteristicItem.value == "HomePhone" {
								imageName = "icLandlineOrCallMinutes"
							} else if characteristicItem.value == "Data" {
								imageName = "icData"
							} else if characteristicItem.value == "Roaming" {
								imageName = "icCountry"
							}
						} else if characteristicItem.name == .description {
							description = characteristicItem.value
						}
					}

					let detailItem = BillDetailItemModel(imageName: imageName,
														 description: description,
														 amount: nil,
														 date: nil)
					list.append(detailItem)
				} else if isBundle == false, productList.count == 3 {
					var imageName: String?
					var description: String = ""
					var amount: String?
					for characteristicItem in productList {
						if characteristicItem.name == .serviceType {
							if characteristicItem.value == "Broadband" {
								imageName = "icWifiBroadband"
							} else if characteristicItem.value == "TV" {
								imageName = "icTv"
							} else if characteristicItem.value == "HomePhone" {
								imageName = "icLandlineOrCallMinutes"
							} else if characteristicItem.value == "Data" {
								imageName = "icData"
							} else if characteristicItem.value == "Roaming" {
								imageName = "icCountry"
							}
						} else if characteristicItem.name == .description {
							description = characteristicItem.value
						} else if characteristicItem.name == .amount {
							amount = "\(characteristicItem.value)\(otherChargesAmount?.unit.moneySymbol ?? "")"
						}
					}

					let detailItem = BillDetailItemModel(imageName: imageName,
														 description: description,
														 amount: amount,
														 date: nil)
					list.append(detailItem)
				}
			}
		}

		return list
	}

	var totalOutOfAmount: String {
		var total: Double = 0
		var unit: String = ""

		if let outOfBundleList = outOfBundleAmount {
			for outOfBundleItem in outOfBundleList {
				total += outOfBundleItem.value
				unit = outOfBundleItem.unit
			}
		}

		return "\(total)\(unit.moneySymbol)"
	}

	var totalPayAmount: String {
		var total: Double = 0
		var unit: String = ""

		if let monthlyFeeAmount = totalBeforeVAT {
			total += monthlyFeeAmount.value
			unit = monthlyFeeAmount.unit
		}

		if let vatAmount = totalVAT {
			total += vatAmount.value
		}

		return "\(total)\(unit.moneySymbol)"
	}
}
