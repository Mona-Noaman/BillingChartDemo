//
//  String+Localization.swift
//  mva10
//
//  Created by Mahmoud Amer on 12/25/18.
//  Copyright © 2018 Vodafone. All rights reserved.
//

import Foundation

extension String {
    public func localized(manager: VFGContentManager = VFGContentManager.shared,
                          bundle: Bundle? = nil) -> String {
        return manager.value(for: self, in: bundle)
    }
}
