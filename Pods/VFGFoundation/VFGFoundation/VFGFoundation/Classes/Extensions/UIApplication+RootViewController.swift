//
//  UIApplication+RootViewController.swift
//  VFGMVA10Group
//
//  Created by Mohamed Mahmoud Zaki on 5/7/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    public class func topViewController(base: UIViewController? =
        UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
            return topViewController(base: selected)
        } else if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
