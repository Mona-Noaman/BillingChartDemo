//
//  UIView+GestureRecognizer.swift
//  VFGMVA10Group
//
//  Created by Sandra Morcos on 3/26/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    public func removeGestures() {
        guard let gestures = gestureRecognizers else {
            return
        }
        for gesture in gestures {
            removeGestureRecognizer(gesture)
        }
    }
}
