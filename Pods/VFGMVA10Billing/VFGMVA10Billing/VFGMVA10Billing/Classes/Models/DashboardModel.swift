//
//  Dashboard.swift
//  VFGMVA10Group
//
//  Created by Samet MACİT on 2.12.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

// MARK: - Dashboard
public struct DashboardModel: Codable {
    public var amountDue: AmountDue
    public var outOfBundleAmount: [OutOfBundleAmount]
    public var month: String
}

extension DashboardModel: DashboardModelProtocol {}
