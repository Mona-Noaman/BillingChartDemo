//
//  VFGMVa10SplashDelegate.swift
//  VFGMVA10Splash
//
//  Created by Hussien Gamal Mohammed on 9/19/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

public protocol VFGMVa10SplashDelegate: class {
    var logoFrame: CGRect {get}
    var useSplashDefaultAnimation: Bool {get}
    var nextViewControllerBGColor: UIColor? {get}
    var nextViewControllerBGImage: UIImage? {get}
    var logo: UIImage? {get}
    func splashTransitionsWillStart(duration: Double, delay: Double, completion: (() -> Void)?)
    func splashTransitionsDidFinish()
}
