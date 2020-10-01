//
//  UIView+Xib.swift
//  VFGFoundation
//
//  Created by Tomasz Czyżak on 14/07/2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

extension UIView {
    public class func loadXib<T: UIView>(bundle: Bundle = Bundle.main, nibName: String = String("\(T.self)")) -> T? {
        return bundle.loadNibNamed(nibName, owner: self, options: nil)?.first as? T
    }
}
