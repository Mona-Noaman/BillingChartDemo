//
//  VFGChartView+UICollectionView.swift
//  VFGMVA10Billing
//
//  Created by Hussein Kishk on 7/22/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation
import UIKit
import VFGFoundation

extension VFGChartView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if showShimmer {
            return defaultShimmerCount
        }
        if shouldAnimate {
            return (dataProvider?.barData.count ?? 0) + VFGMVA10BillingConstants.emptyBarsCount
        }
        return dataProvider?.barData.count ?? 0
    }

    fileprivate func animateBarsOnce(_ collectionView: UICollectionView) {
        if shouldAnimate {
            let maxItemsPerScreen = VFGMVA10BillingConstants.maxItemsPerScreen
            let singleBarHeightDuration = VFGMVA10BillingConstants.singleBarHeightDuration
            let delay = Double(maxItemsPerScreen * singleBarHeightDuration)
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                self.shouldAnimate = false
                collectionView.reloadData()
            }
        }
    }

    fileprivate func dimUnselectedCells(_ cell: ChartBarCell, _ row: Int ) {
        let isLastRow = ((dataProvider?.barData.count ?? 0) - 1) == row
        if isLastRow && lastBillHasOutline {
            cell.barView.layer.borderWidth = 1
            if selectedIndexPath?.row != row, isExpanded {
                cell.barView.layer.borderColor = unselectedBarsColor.cgColor
            } else {
                cell.barView.layer.borderColor = UIColor.VFGChartBarsActive.cgColor
            }
            cell.barView.backgroundColor = .clear
        } else {
            cell.barView.layer.borderWidth = 0
            if isExpanded {
                if selectedIndexPath?.row == row {
                    cell.barView.backgroundColor = .VFGChartBarsActive
                } else {
                    cell.barView.backgroundColor = unselectedBarsColor
                }
            } else {
                cell.barView.backgroundColor = .VFGChartBarsActive
            }
        }
    }

    fileprivate func updateMonthLabel() {
        for row in 0..<chartCollectionView.numberOfItems(inSection: 0) {
            let cellIndexPath = IndexPath(row: row, section: 0)
            if let cell = chartCollectionView.cellForItem(at: cellIndexPath) as? ChartBarCell {
                updateMonthLabel(for: cell)
            }
        }
    }

    fileprivate func updateMonthLabel(for cell: ChartBarCell) {
        if !isExpanded {
            cell.barBillMonthLabel.font = UIFont.vodafoneRegular(14)
            cell.barBillMonthLabel.textColor = .VFGSecondaryText
        } else if cell.isExpanded {
            cell.barBillMonthLabel.font = UIFont.vodafoneBold(14)
            cell.barBillMonthLabel.textColor = .VFGPrimaryText
        } else {
            cell.barBillMonthLabel.font = UIFont.vodafoneRegular(14)
            cell.barBillMonthLabel.textColor = .VFGUnselectedText
        }
    }

    fileprivate func showHideYearLabel(_ cell: ChartBarCell) {
        if cell.isDecember {
            if cell.isExpanded {
                cell.barbillYearLabel.isHidden = true
                cell.barBillDescriptionView.isHidden = false
            } else {
                cell.barbillYearLabel.isHidden = false
                cell.barBillDescriptionView.isHidden = true
            }
        } else {
            cell.barbillYearLabel.isHidden = true
            cell.barBillDescriptionView.isHidden = false
        }
    }

    func showHideBarDescView(_ cell: ChartBarCell,
                             index: IndexPath,
                             completion: ((Bool) -> Void)? = nil) {
        if selectedIndexPath == index {
            if cell.isExpanded {
                DispatchQueue.main.asyncAfter(deadline: .now() +
                    VFGMVA10BillingConstants.chartBarCellShowContentDelay) {
                        UIView.animate(withDuration:
                            VFGMVA10BillingConstants.chartBarCellWidthResizeDuration, animations: {
                                cell.barBillDescriptionView.alpha = 1

                        }, completion: completion)
                }
            } else {
                UIView.animate(withDuration: VFGMVA10BillingConstants.chartBarCellWidthResizeDuration,
                               delay: VFGMVA10BillingConstants.chartBarCellWidthResizeDelay,
                               options: .beginFromCurrentState, animations: {
                                cell.barBillDescriptionView.alpha = 0
                }, completion: completion)
            }
        } else {
            UIView.animate(withDuration: VFGMVA10BillingConstants.chartBarCellWidthResizeDuration,
                           delay: VFGMVA10BillingConstants.chartBarCellWidthResizeDelay,
                           options: .beginFromCurrentState, animations: {
                            cell.barBillDescriptionView.alpha = 0
            }, completion: completion)
        }
    }

    func changeBarColors(for cell: ChartBarCell?,
                         _ row: Int,
                         _ borderColor: CGColor,
                         _ barBackgroundColor: UIColor) {
        let isLastRow = ((dataProvider?.barData.count ?? 0) - 1) == row
        if isLastRow && lastBillHasOutline {
            cell?.barView.backgroundColor = .VFGWhiteBackground
            cell?.barView.layer.borderColor = borderColor
        } else {
            if selectedIndexPath?.row != row {
                cell?.barView.backgroundColor = barBackgroundColor
            }
        }
    }

    func changeBarColors(borderColor: CGColor, barBackgroundColor: UIColor) {
        for row in 0..<chartCollectionView.numberOfItems(inSection: 0) {
            let cellIndexPath = IndexPath(row: row, section: 0)
            let cell = chartCollectionView.cellForItem(at: cellIndexPath) as? ChartBarCell
            changeBarColors(for: cell,
                            row,
                            borderColor,
                            barBackgroundColor)
        }
    }

    public func shimmerCell(indexPath: IndexPath,
                            collectionView: UICollectionView) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartShimmerCell",
                                                                   for: indexPath)
        guard let cellUnwapped = cell as? ChartShimmerCell else {return UICollectionViewCell()}
        cellUnwapped.configureCell()
        cellUnwapped.isUserInteractionEnabled = false
        return cellUnwapped
    }

    public func chartBarCell(indexPath: IndexPath,
                             collectionView: UICollectionView) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartBarCell",
                                                            for: indexPath)
            as? ChartBarCell, let data = dataProvider?.barData else { return UICollectionViewCell() }
        cell.delegate = delegate
        animateBarsOnce(collectionView)
        var bar = Bar()
        if indexPath.row < data.count {
            bar = data[indexPath.row]
        }
        cell.shouldAnimate = shouldAnimate
        cell.configure(bar: bar,
                       maxBarHeightValue: dataProvider?.maxBarHeightValue ?? 0.0,
                       row: indexPath.row,
                       totalBarsCount: data.count,
                       billsHaveNegativeValue: billsHaveNegativeValue)
        return cell
    }

    func shouldExpand(_ cell: ChartBarCell, at indexPath: IndexPath) {
        if isExpanded, selectedIndexPath == indexPath {
            cell.isExpanded = true
        } else {
            cell.isExpanded = false
        }
        showHideBarDescView(cell, index: indexPath)
        showHideYearLabel(cell)
        updateMonthLabel(for: cell)
        dimUnselectedCells(cell, indexPath.row)
    }

    func deselectCellAt(cell: ChartBarCell, indexPath: IndexPath) {
        UIView.animate(withDuration: VFGMVA10BillingConstants.chartBarCellWidthResizeDuration,
                       delay: VFGMVA10BillingConstants.chartBarCellWidthResizeDelay,
                       options: .beginFromCurrentState, animations: {
                        cell.barBillDescriptionView.alpha = 0
        }, completion: nil)
        cell.isExpanded = false
        isExpanded = false
        chartCollectionView.performBatchUpdates(({}), completion: nil)
        showHideYearLabel(cell)
        updateMonthLabel()
        UIView.animate(withDuration: VFGMVA10BillingConstants.chartBarCellResizeDuration,
                       delay: 0, options: [], animations: {
                        self.dimUnselectedCells(cell, indexPath.row)
        }, completion: nil)
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            if showShimmer {
                return shimmerCell(indexPath: indexPath,
                                   collectionView: collectionView)
            } else {
                guard let cell = chartBarCell(indexPath: indexPath,
                                              collectionView: collectionView)
                    as? ChartBarCell else { return UICollectionViewCell() }
                shouldExpand(cell, at: indexPath)
                return cell
            }
    }
}

extension VFGChartView: UICollectionViewDelegate {
     func barCellAnimationUIForNotExpanded(_ cell: ChartBarCell,
                                           _ indexPath: IndexPath,
                                           animationCompletion: ((Bool) -> Void)? = nil) {
        cell.isExpanded = true
        isExpanded = true
        UIView.animate(withDuration: VFGMVA10BillingConstants.chartBarCellColorFadingDuration,
                       delay: 0, options: [], animations: { [weak self] in
                        guard let self = self else { return }
                        self.changeBarColors(borderColor: self.unselectedBarsColor.cgColor,
                                             barBackgroundColor: self.unselectedBarsColor)
        }, completion: animationCompletion)
        if selectedIndexPath == indexPath {
            if ((dataProvider?.barData.count ?? 0) - 1) == indexPath.row {
                cell.barView.backgroundColor = .VFGWhiteBackground
            } else {
                UIView.animate(withDuration: VFGMVA10BillingConstants.chartBarCellColorFadingDuration,
                               delay: 0, options: [], animations: {
                                cell.barView.backgroundColor = .VFGChartBarsActive
                }, completion: animationCompletion)
            }
        }
    }

    func barCellAnimationUIForExpanded(_ cell: ChartBarCell,
                                       completion: ((Bool) -> Void)? = nil) {
        cell.isExpanded = false
        isExpanded = false
        UIView.animate(withDuration: VFGMVA10BillingConstants.chartBarCellColorFadingDuration,
                       delay: 0, options: [], animations: {
                        self.changeBarColors(borderColor: UIColor.VFGChartBarsActive.cgColor,
                                             barBackgroundColor: .VFGChartBarsActive)
        }, completion: completion)
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if dataProvider?.barData.count ?? 0 > indexPath.row,
            !(dataProvider?.barData[indexPath.row].info ?? "").isEmpty {
            if selectedIndexPath != indexPath,
                let cell = collectionView.cellForItem(at: selectedIndexPath ?? indexPath)
                    as? ChartBarCell {
                deselectCellAt(cell: cell, indexPath: selectedIndexPath ?? indexPath)
            }
            selectedIndexPath = indexPath
            guard let cell = collectionView.cellForItem(at: indexPath) as? ChartBarCell else { return }
            if cell.isExpanded {
                barCellAnimationUIForExpanded(cell)
                delegate?.didDeselectBillAt(row: ((dataProvider?.barData.count ?? 0) - indexPath.row - 1))
                isExpanded = false
            } else {
                barCellAnimationUIForNotExpanded(cell, indexPath)
                delegate?.didSelectBillAt(row: ((dataProvider?.barData.count ?? 0) - indexPath.row - 1))
            }

            UIView.animate(withDuration: VFGMVA10BillingConstants.chartBarCellResizeDuration) {
                self.showHideBarDescView(cell, index: indexPath)
            }
            showHideYearLabel(cell)
            updateMonthLabel()
            dimUnselectedCells(cell, indexPath.row)
            collectionView.performBatchUpdates(({}), completion: nil)
            guard let count = dataProvider?.barData.count else { return }
            if (count - 1) == indexPath.row || (count - 2) == indexPath.row {
                let lastRow = count - 1
                let indexPath = IndexPath(row: lastRow, section: 0)
                self.chartCollectionView?.scrollToItemIfValid(at: indexPath, at: .right, animated: true)
            }
        }
    }

    public func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ChartBarCell else { return }
        UIView.animate(withDuration: VFGMVA10BillingConstants.chartBarCellWidthResizeDuration,
                       delay: VFGMVA10BillingConstants.chartBarCellWidthResizeDelay,
                       options: .beginFromCurrentState, animations: {
                        cell.barBillDescriptionView.alpha = 0
        }, completion: nil)
        cell.isExpanded = false
        isExpanded = false
        collectionView.performBatchUpdates(({}), completion: nil)
        showHideYearLabel(cell)
        updateMonthLabel()
        UIView.animate(withDuration: VFGMVA10BillingConstants.chartBarCellResizeDuration,
                       delay: 0, options: [], animations: {
                        self.dimUnselectedCells(cell, indexPath.row)
        }, completion: nil)
    }
}

extension VFGChartView: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: VFGMVA10BillingConstants.barCollectionCellWidth,
                          height: VFGMVA10BillingConstants.barCollectionCellHeight)

        guard let cell = collectionView.cellForItem(at: indexPath) as? ChartBarCell else { return size }
        if selectedIndexPath == indexPath, cell.isExpanded {
            size.width = CGFloat(VFGMVA10BillingConstants.barCollectionCellExpandedWidth)
            if cell.isDecember {
                size.width += 20
            }
        }
        return size
    }
}
