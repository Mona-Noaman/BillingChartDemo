//
//  VFGMVA10BillingConstants.swift
//  VFGMVA10Billing
//
//  Created by Hussein Kishk on 5/20/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation
import UIKit

public struct VFGMVA10BillingConstants {
    // Identifiers
    static let barCollectionCellWidth: CGFloat = 40.0
    static let barCollectionCellExpandedWidth = 120.0
    static let barCollectionCellHeight: CGFloat = 204.0
    static let maxItemsPerScreen: CGFloat = UIScreen.main.bounds.width / VFGMVA10BillingConstants.barCollectionCellWidth
    static let emptyBarsCount = 4
    static let chartBarCellResizeDuration = 0.3
    static let chartBarCellColorFadingDuration = 0.4
    static let chartBarFirstSelectionCell = 0.5

    static let singleBarHeightDuration: CGFloat = 0.065
    static let totalBarsAnimationDelay = 0.65
    static let monthsInTwoYears = 24
    static let decemberId = 12
    static let chartBarCellWidthResizeDuration = 0.12
    static let chartBarCellWidthResizeDelay = 0.025
    static let barViewHeight: CGFloat = 24
    static let lastRowBarBottomConstraint: CGFloat = 34
    static let barBottomConstraint: CGFloat = 58
    static let currentCellHeight: CGFloat = 360
    static let currentCellHeightWithPDF: CGFloat = 400
    static let chartBarCellShowContentDelay = 0.05
}
