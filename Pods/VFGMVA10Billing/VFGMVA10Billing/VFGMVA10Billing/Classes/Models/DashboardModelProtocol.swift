//
//  DashboardModelProtocol.swift
//  VFGMVA10Billing
//
//  Created by Salma Ashour on 8/23/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public protocol DashboardModelProtocol {
    var amountDue: AmountDue { get }
    var outOfBundleAmount: [OutOfBundleAmount] { get }
    var month: String { get }
}
