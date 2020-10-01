//
//  VFGChartView.swift
//  VFGMVA10Billing
//
//  Created by Salma Ashour on 5/19/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

public class VFGChartView: UIView {
    let defaultShimmerCount = 11
    var selectedIndexPath: IndexPath?
    var isExpanded = false
    var showShimmer = true
    var shouldAnimate = true
    var billsHaveNegativeValue = false
    var dataProvider: VFGChartDataProvider?
    var unselectedBarsColor: UIColor = .VFGChartBarsUnselected
    var isFirstDraw = true
    var firstDrawSelectedIndex: Int?
    public var lastBillHasOutline = true
    public var priceFormat = "%1$@ %2$@"

    public var unselectedBarsBackgroundStyle: UnselectedBarsColor = .gray {
        didSet {
            switch unselectedBarsBackgroundStyle {
            case .gray:
                unselectedBarsColor = .VFGChartBarsUnselected
            case .red:
                unselectedBarsColor = .VFGChartBarsUnselectedRed
            }
        }
    }

    public var minBarsToBeViewed = 12
    public weak var delegate: ChartViewDelegate?

    public var selectedRow: Int? {
        guard let row = selectedIndexPath?.row, isExpanded else { return nil }
        return  (dataProvider?.barData.count ?? 0) - row - 1
    }

    @IBOutlet weak var chartCollectionView: UICollectionView! {
        didSet {
            chartCollectionView.register(UINib(nibName: String(describing: ChartBarCell.self),
                                               bundle: Bundle.mva10Billing), forCellWithReuseIdentifier: "ChartBarCell")
        }
    }

    public override func awakeFromNib() {
        chartCollectionView.register(UINib(nibName: "ChartShimmerCell",
                                           bundle: Bundle.mva10Billing), forCellWithReuseIdentifier: "ChartShimmerCell")
        chartCollectionView.dataSource = self
        chartCollectionView.delegate = self
        dataProvider = VFGChartDataProvider()
    }
}

extension VFGChartView {
    func animateScrollToLastItem(completion: ((Bool) -> Void)? = nil) {
        UIView.animate(withDuration: 0.15, delay: 0.0,
                       options: .beginFromCurrentState,
                       animations: {[weak self] in
                        guard let self = self else { return }
                        let lastRow = (self.dataProvider?.barData.count ?? 1) - 1
                        let indexPath = IndexPath(row: lastRow, section: 0)
                        self.calculateSectionInset()
                        self.chartCollectionView?.scrollToItemIfValid(at: indexPath, at: .right, animated: false)
            }, completion: completion)
    }

    func calculateSectionInset() {
        let sectionLeftInset = UIScreen.main.bounds.width -
            CGFloat(dataProvider?.barData.count ?? 0) * VFGMVA10BillingConstants.barCollectionCellWidth
        if sectionLeftInset > 0 {
            chartCollectionView.contentInset = UIEdgeInsets(top: 0, left: sectionLeftInset, bottom: 0, right: 0)
        } else {
            chartCollectionView.contentInset = UIEdgeInsets.zero
        }
    }

    func configureUI() {
        showShimmer = false
        chartCollectionView.reloadData()
        guard let barData = dataProvider?.barData else {
             return
        }
        for bar in barData where bar.value < 0 {
            billsHaveNegativeValue = true
        }
        let lastRow = (barData.count) - 1
        let indexPath = IndexPath(row: lastRow, section: 0)
        chartCollectionView.contentInset = UIEdgeInsets(
            top: 0,
            left: 0,
            bottom: 0,
            right: CGFloat(VFGMVA10BillingConstants.barCollectionCellWidth * 4))
        chartCollectionView?.scrollToItemIfValid(at: indexPath, at: .right, animated: false)
        animateScrollToLastItem { (_) in
            self.animateToSelectedIndex()
        }
        chartCollectionView.layoutIfNeeded()
    }

    func animateToSelectedIndex() {
        if let rowSelected = firstDrawSelectedIndex {
            DispatchQueue.main.asyncAfter(deadline: .now() + VFGMVA10BillingConstants.chartBarFirstSelectionCell) {
                let barDataCount = self.dataProvider?.barData.count ?? 0
                let selectedIndexRow = (barDataCount - 1) - rowSelected
                if barDataCount > rowSelected {
                    let index = IndexPath(item: selectedIndexRow, section: 0)
                    self.chartCollectionView.scrollToItemIfValid(at: index,
                                                                 at: .left, animated: true,
                                                                 completion: {
                                                                    self.collectionView(self.chartCollectionView,
                                                                                        didSelectItemAt:
                                                                        IndexPath(item: index.row, section: 0)) })
                }
                self.firstDrawSelectedIndex = nil
            }
        } else {
            isFirstDraw = false
        }
    }

    public func configure(dashboardList: [HistoryModelProtocol]) {
        chartCollectionView?.reloadData()
        dataProvider?.populateChartData(
            dashboardList: dashboardList,
            priceFormat: self.priceFormat,
            minBarsToBeViewed: minBarsToBeViewed,
            completion: { [weak self] in
                guard let self = self else { return }
                self.configureUI()
        })
    }

    public func reloadChartView(dashboardList: [HistoryModelProtocol]) {
        showShimmer = true
        chartCollectionView?.reloadData()
        dataProvider?.populateChartData(dashboardList: dashboardList,
                                        priceFormat: priceFormat,
                                        minBarsToBeViewed: minBarsToBeViewed,
                                        completion: { [weak self] in
            guard let self = self else { return }
            self.shouldAnimate = true
            self.isExpanded = false
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                self.configureUI()
            }
        })
    }
}
