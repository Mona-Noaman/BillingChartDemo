//
//  IntExtension.swift
//  VFGFoundation
//
//  Created by Hussien Gamal Mohammed on 7/9/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

internal extension Int {
    func times(closure: (_ index: Int) -> Void) {
        if self > 0 {
            for index in 0..<self {
                closure(index)
            }
        }
    }

    func times( closure: @autoclosure () -> Void) {
        if self > 0 {
            for _ in 0..<self {
                closure()
            }
        }
    }
}
