//
//  UIScrollView+Offsets.swift
//  VFGMVA10Group
//
//  Created by Mohamed Mahmoud Zaki on 4/2/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation
import UIKit

extension UIScrollView {
    public func scrollToBottom(animated: Bool) {
        if contentSize.height < bounds.size.height {
            return
        }
        let bottomOffset = CGPoint(x: 0, y: contentSize.height - bounds.size.height)
        setContentOffset(bottomOffset, animated: animated)
    }
}
