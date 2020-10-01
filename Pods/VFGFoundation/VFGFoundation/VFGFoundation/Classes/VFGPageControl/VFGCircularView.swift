//
//  VFGCircularView.swift
//  VFGFoundation
//
//  Created by Yahya Saddiq on 3/29/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

class VFGCircularView: UIView {
    var dotSize: CGFloat

    override init(frame: CGRect) {
        dotSize = frame.size.width
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        dotSize = 0
        super.init(coder: coder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = dotSize / 2
    }
}
