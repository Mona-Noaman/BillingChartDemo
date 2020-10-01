//
//  BillingDetailViewModelProtocol.swift
//  VFGBilling
//
//  Created by Mert Karabulut on 19.12.2019.
//

import Foundation

public protocol BillingDetailViewModelProtocol {
    var delegate: BillingDetailViewModelDelegate? { get set }
    func setup()
}

public enum BillingDetailViewModelOutput {
    case updateBillingDetail(BillDetailModelProtocol?, Error?)
    case showBillDetailsShimmer
}

public protocol BillingDetailViewModelDelegate: class {
    func handleViewModelOutput(_ output: BillingDetailViewModelOutput)
}
