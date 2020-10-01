//
//  VFQuickActionsProtocol.swift
//  VFGFoundation
//
//  Created by Esraa Eldaltony on 1/14/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public protocol VFQuickActionsProtocol: class {
    func reloadQuickAction(model: VFQuickActionsModel?)
    func closeQuickAction()
}
