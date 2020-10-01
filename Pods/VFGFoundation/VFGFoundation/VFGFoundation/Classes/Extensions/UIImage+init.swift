//
//  UIImage+init.swift
//  VFGFoundation
//
//  Created by Ahmed Sultan on 6/7/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation
import UIKit
/// UIImage init failable without compatible parameters
extension UIImage {
    public convenience init?(named name: String?, in bundle: Bundle?) {
        if let name = name {
            self.init(named: name, in: bundle, compatibleWith: nil)
        } else {
            return nil
        }
    }
}
