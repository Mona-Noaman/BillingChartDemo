//
//  BillDetailItemModel.swift
//  VFGBilling
//
//  Created by Mert Karabulut on 24.12.2019.
//

import Foundation

public struct BillDetailItemModel: Codable {
    public var imageName: String?
    public var description: String
    public var amount: String?
    public var date: String?
}

extension BillDetailItemModel: BillDetailItemModelProtocol {}
