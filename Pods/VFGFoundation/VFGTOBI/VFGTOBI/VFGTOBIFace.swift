//
//  VFGTOBIFace.swift
//  TOBI
//
//  Created by Ehab Amer on 10/1/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit
import Lottie

public protocol VFGTOBIFaceDelegate: class {
    func animationStarted(_ animationName: VFGTOBIAnimationNames)
    func animationFinished(_ animationName: VFGTOBIAnimationNames)
}

open class VFGTOBIFace: UIView {

    public var animationToDo: VFGTOBIAnimationNames?
    public var lastAnimationObject: VFGTOBIAnimationNames?
    var animationView: AnimationView
    public weak var delegate: VFGTOBIFaceDelegate?
    @IBInspectable public var useLongIdles: Bool = false
    @IBInspectable public var shortIdleWaitDuration: Double = 5.0
    private var isIdle = false
    public static var defaultSet = VFGTOBISet.default

    open override func layoutSubviews() {
        super.layoutSubviews()
        layoutAnimationView()
    }

    private func layoutAnimationView() {
        var frame = self.frame
        let originalFrame = self.frame
        frame.origin = CGPoint(x: -0.75 * originalFrame.width, y: -0.75 * originalFrame.height)
        frame.size.width += 1.5 * originalFrame.width
        frame.size.height += 1.5 * originalFrame.height
        animationView.frame = frame
    }

    private func animate(_ animationName: VFGTOBIAnimation) {
        isIdle = false
        lastAnimationObject = animationName
        animationView.play(
            fromMarker: animationName.marker.start,
            toMarker: animationName.marker.end,
            loopMode: .playOnce
        ) { [weak self] (_)  in
            guard let self = self else { return }
            if self.lastAnimationNotIdle() {
                if let lastAnimationObject = self.lastAnimationObject {
                    self.delegate?.animationFinished(lastAnimationObject)
                }
            }
            self.finishedAnimation()
        }
    }

    public override init(frame: CGRect) {
        animationView = AnimationView(name: VFGTOBIFace.defaultSet.rawValue, bundle: Bundle(for: VFGTOBIFace.self))
        super.init(frame: frame)
        animationView.accessibilityIdentifier = "loginTobiIcon"
        layoutAnimationView()
        animationView.contentMode = .scaleAspectFit
        addSubview(animationView)

        startIdle()
    }

    public required init?(coder aDecoder: NSCoder) {
        animationView = AnimationView(name: VFGTOBIFace.defaultSet.rawValue, bundle: Bundle(for: VFGTOBIFace.self))
        super.init(coder: aDecoder)
        animationView.accessibilityIdentifier = "loginTobiIcon"
        layoutAnimationView()
        animationView.contentMode = .scaleAspectFit
        addSubview(animationView)

        startIdle()
    }

    open func begin(_ animationName: VFGTOBIAnimation, animateNow: Bool = false) {
        if isIdle {
            animate(animationName)
        } else {
            delegate?.animationStarted(animationName)
            animationToDo = animationName
            if animateNow {
                animationView.stop()
            }
        }
    }

    open func finishedAnimation() {
        guard let animationToDo = animationToDo else {

            if useLongIdles == false {
                isIdle = true
                DispatchQueue.main.asyncAfter(deadline: .now() + shortIdleWaitDuration) {
                    if self.isIdle == true {
                        self.isIdle = false
                        self.nextIdle()
                    }
                }
            } else {
                nextIdle()
            }
            return
        }
        animate(animationToDo)
        self.animationToDo = nil
    }

    private func lastAnimationNotIdle() -> Bool {
        let idleAnimations: [VFGTOBIAnimation?] = [.idle1,
                                                   .idle1Long,
                                                   .idle2,
                                                   .idle2Long,
                                                   .idle3,
                                                   .idle3Long,
                                                   .idle4,
                                                   .idle4Long]

        return !idleAnimations.contains(lastAnimationObject)
    }

    private func startIdle() {
        animationToDo = nil
        if useLongIdles {
            animate(.idle1Long)
        } else {
            animate(.idle1)
        }
    }

    private func nextIdle() {
        let idleStep = Int.random(in: 1...4)
        switch (idleStep, useLongIdles) {
        case (1, false):
            animate(.idle1)
        case (1, true):
            animate(.idle1Long)
        case (2, false):
            animate(.idle2)
        case (2, true):
            animate(.idle2Long)
        case (3, false):
            animate(.idle3)
        case (3, true):
            animate(.idle3Long)
        case (4, false):
            animate(.idle4)
        case (4, true):
            animate(.idle4Long)
        default:
            animate(.idle1)
        }
    }

    public func switchTo(set: VFGTOBISet) {
        animationView.stop()
        animationView.removeFromSuperview()
        animationView = AnimationView(name: set.rawValue, bundle: Bundle(for: VFGTOBIFace.self))
        animationView.accessibilityIdentifier = "loginTobiIcon"
        layoutAnimationView()
        animationView.contentMode = .scaleAspectFit
        addSubview(animationView)
    }
}
