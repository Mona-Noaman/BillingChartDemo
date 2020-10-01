//
//  VFGStepControlDelegate.swift
//  VFGFoundation
//
//  Created by Yahya Saddiq on 8/25/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

public protocol VFGStepControlDelegate: NSObjectProtocol {
    func stepControl(_ stepControl: VFGStepControl, didCompleteStepAt index: Int)
    func stepControl(_ stepControl: VFGStepControl, didReturnToStepAt index: Int)
    func stepControl(_ stepControl: VFGStepControl, didSkipStepAt index: Int)
    func stepControl(_ stepControl: VFGStepControl, didAddStepAt index: Int)
    func stepControl(_ stepControl: VFGStepControl, didMoveToStepAt index: Int)
}

public extension VFGStepControlDelegate {
    func stepControl(_ stepControl: VFGStepControl, didSkipStepAt index: Int) { }
    func stepControl(_ stepControl: VFGStepControl, didAddStepAt index: Int) { }
    func stepControl(_ stepControl: VFGStepControl, didMoveToStepAt index: Int) { }
}
