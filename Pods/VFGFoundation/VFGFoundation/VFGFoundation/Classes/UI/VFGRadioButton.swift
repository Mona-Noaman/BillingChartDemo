//
//  VFGRadioButton.swift
//  VFGFoundation
//
//  Created by Hussien Gamal Mohammed on 4/26/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

public class VFGRadioButton: UIButton {
    let activeImage = UIImage(named: "VFGRadioButtonActive",
                              in: Bundle.foundation,
                              compatibleWith: nil)
    let inactiveImage = UIImage(named: "VFGRadioButtonInactive",
                                in: Bundle.foundation,
                                compatibleWith: nil)

    override public var isSelected: Bool {
        didSet {
            setBackgroundImage(isSelected ?
                 activeImage : inactiveImage,
                               for: .normal)
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }

    @objc public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customUI()
    }

    func customUI() {
        setTitle("", for: .normal)
        isSelected = false
    }
}
