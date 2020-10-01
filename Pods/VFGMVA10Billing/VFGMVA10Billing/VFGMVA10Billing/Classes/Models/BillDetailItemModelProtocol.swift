//
//  BillDetailItemModelProtocol.swift
//  VFGMVA10Billing
//
//  Created by Salma Ashour on 9/7/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public protocol BillDetailItemModelProtocol {
    var imageName: String? { get }
    var description: String { get }
    var amount: String? { get }
    var date: String? { get }
}
