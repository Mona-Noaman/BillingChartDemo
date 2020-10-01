//
//  VFQuickActionsModel.swift
//  VFGMVA10Group
//
//  Created by Sandra Morcos on 7/30/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

public enum VFQuickActionsStyle {
    case red, white
}

public protocol VFQuickActionsModel {
    var quickActionsTitle: String { get }
    var quickActionsContentView: UIView { get }
    func quickActionsProtocol(delegate: VFQuickActionsProtocol)
    func closeQuickAction()
    var quickActionsStyle: VFQuickActionsStyle { get }
    var hasMaxWidth: Bool { get }
}

extension VFQuickActionsModel {
    public var quickActionsStyle: VFQuickActionsStyle {
        return .red
    }

    public var hasMaxWidth: Bool {
        false
    }
}
