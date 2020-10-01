//
//  VFGStepControlDataSource.swift
//  VFGFoundation
//
//  Created by Yahya Saddiq on 8/27/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

public protocol VFGStepControlDataSource: NSObjectProtocol {
    func numberOfSteps(_ stepControl: VFGStepControl) -> Int
    func title(_ stepControl: VFGStepControl, forStepAt index: Int) -> String
    func stepsDataURL(_ stepControl: VFGStepControl) -> URL?
}

public extension VFGStepControlDataSource {
    func stepsDataURL(_ stepControl: VFGStepControl) -> URL? {
        nil
    }
}
