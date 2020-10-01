//
//  VFGBillingDataProvider.swift
//  VFGMVA10Group
//
//  Created by Samet MACİT on 9.12.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation
import VFGFoundation

public protocol VFGBillingDataProviderProtocol {
    func fetchHistoryData(completion: @escaping ([HistoryModelProtocol]?, Error?) -> Void)
    func fetchBillDetail(billId: String, completion: @escaping (BillDetailModelProtocol?, Error?) -> Void)
    func fetchBalanceData(completion: @escaping (BillModelProtocol?, Error?) -> Void)
    var enableCurrentPDFCell: Bool? { get set }
    func pdfButtonPressed(at indexPath: IndexPath) -> UIViewController?
}
