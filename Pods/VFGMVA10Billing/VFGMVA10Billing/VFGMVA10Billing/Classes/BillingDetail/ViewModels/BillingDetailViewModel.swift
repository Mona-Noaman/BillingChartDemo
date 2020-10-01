//
//  BillingDetailViewModel.swift
//  VFGBilling
//
//  Created by Mert Karabulut on 19.12.2019.
//

import Foundation

public final class BillingDetailViewModel: BillingDetailViewModelProtocol {
    weak public var delegate: BillingDetailViewModelDelegate?
    private let dataProvider: VFGBillingDataProviderProtocol
	private let billId: String

	public init(dataProvider: VFGBillingDataProviderProtocol, billId: String) {
        self.dataProvider = dataProvider
		self.billId = billId
    }

    public func setup() {
        fetchBillingDetail()
    }

    public func fetchBillingDetail() {
        self.notify(.showBillDetailsShimmer)
		dataProvider.fetchBillDetail(billId: self.billId) { [weak self] (result, error) in
			guard let self = self else { return }
            if let result = result {
				self.notify(.updateBillingDetail(result, error))
            }
			return
		}
    }

    private func notify(_ output: BillingDetailViewModelOutput) {
        delegate?.handleViewModelOutput(output)
    }
}
