//
//  UICollectionView+ScrollToItemIfValid.swift
//  VFGMVA10Billing
//
//  Created by Mohamed Abd ElNasser on 6/9/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

extension UICollectionView {
    func scrollToItemIfValid(at indexPath: IndexPath,
                             at scrollPosition: UICollectionView.ScrollPosition,
                             animated: Bool,
                             completion: (() -> Void)? = nil) {
        if indexPath.section <= numberOfSections,
            indexPath.row < numberOfItems(inSection: indexPath.section) {
            scrollToItem(at: indexPath,
                         at: scrollPosition,
                         animated: animated)
            DispatchQueue.main.asyncAfter(deadline: .now() +
                VFGMVA10BillingConstants.chartBarCellResizeDuration,
                                          execute: {
                                            completion?()
            })
        }
    }
}
