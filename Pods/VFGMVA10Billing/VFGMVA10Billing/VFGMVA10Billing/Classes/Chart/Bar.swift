//
//  Bar.swift
//  VFGMVA10Group
//
//  Created by Samet MACİT on 29.11.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

public struct Bar {
    let title: String
    let value: Double
    let info: String
    let startDateTime: String
    let endDateTime: String
    let billDateInterval: String
    let billMonthID: Int
    let billYear: String

    init(title: String = "",
         value: Double = 0.0,
         info: String = "",
         startDateTime: String = "",
         endDateTime: String = "",
         billDateInterval: String = "",
         billMonthID: Int = 0,
         billYear: String = "") {
        self.title = title
        self.value = value
        self.info = info
        self.billDateInterval = billDateInterval
        self.billMonthID = billMonthID
        self.billYear = billYear
        self.startDateTime = startDateTime
        self.endDateTime = endDateTime
    }
}
