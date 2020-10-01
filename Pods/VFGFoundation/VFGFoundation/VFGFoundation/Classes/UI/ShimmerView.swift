//
//  ShimmerView.swift
//  VFGFoundation
//
//  Created by Mohamed Mahmoud Zaki on 1/6/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public class ShimmerView: UIView {

    public func startAnimation(duration: TimeInterval = 1.0,
                               completion: (() -> Void)? = nil) {
        let gradientColorOne = UIColor.VFGShimmerViewEdge.cgColor
        let gradientColorTwo = UIColor.VFGShimmerViewCenter.cgColor
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            self.layer.masksToBounds = true
            let gradientLayer = CAGradientLayer()
            var frame = self.bounds
            frame.size.width *= 2
            gradientLayer.frame = frame
            gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
            gradientLayer.colors = [gradientColorOne, gradientColorTwo, gradientColorOne]
            gradientLayer.locations = [0.0, 0.25, 0.75]
            self.layer.addSublayer(gradientLayer)
            let animation = CABasicAnimation(keyPath: "locations")
            animation.fromValue = [-1, -0.75, -0.25]
            animation.toValue = [1, 1.25, 1.75]
            animation.repeatCount = .infinity
            animation.duration = duration
            gradientLayer.add(animation, forKey: animation.keyPath)
            completion?()
        }
    }

}
