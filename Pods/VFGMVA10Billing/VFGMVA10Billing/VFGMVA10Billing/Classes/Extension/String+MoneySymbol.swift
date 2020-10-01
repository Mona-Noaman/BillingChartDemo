//
//  String+MoneySymbol.swift
//  VFGMVA10Group
//
//  Created by Samet MACİT on 10.12.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

public extension String {
    var moneySymbol: String {
       switch self {
       case "GBP": return "\u{00a3}"
       case "EUR": return "\u{20ac}"
       case "USD": return "\u{0024}"
       case "TRY": return "\u{20BA}"
       case "TL": return "\u{20BA}"
       default: return ""
        }
    }
}
