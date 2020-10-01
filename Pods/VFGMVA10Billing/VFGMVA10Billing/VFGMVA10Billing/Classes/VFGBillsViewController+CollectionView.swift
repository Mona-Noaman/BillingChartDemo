//
//  VFGBillsViewController+CollectionView.swift
//  VFGMVA10Billing
//
//  Created by Hussien Gamal Mohammed on 5/7/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation
import VFGFoundation

// MARK: - register cells
extension VFGBillsViewController {
    func registerCells() {
        collectionView.register(BillingChartCollectionCell.self, forCellWithReuseIdentifier: "ChartCell")
        collectionView.register(UINib(nibName: "CurrentBillCollectionCell",
                                      bundle: Bundle.mva10Billing),
                                forCellWithReuseIdentifier: "CurrentBillCell")
        collectionView.register(UINib(nibName: "NegativeBillCollectionCell",
                                      bundle: Bundle.mva10Billing),
                                      forCellWithReuseIdentifier: "NegativeBillCell")
        collectionView.register(UINib(nibName: "CurrentBillPDFCell",
                                      bundle: Bundle.mva10Billing),
                                forCellWithReuseIdentifier: "CurrentBillPDFCell")
        collectionView.register(UINib(nibName: "NegativeBillPDFCell",
                                      bundle: Bundle.mva10Billing),
                                      forCellWithReuseIdentifier: "NegativeBillPDFCell")
        collectionView.register(UINib(nibName: "PrevBillCollectionCell",
                                      bundle: Bundle.mva10Billing),
                                forCellWithReuseIdentifier: "PrevBillCell")
        collectionView.register(UINib(nibName: "ShowMoreCell",
                                      bundle: Bundle.mva10Billing),
                                forCellWithReuseIdentifier: "ShowMoreCell")
        collectionView.register(UINib(nibName: "CurrentBillShimmerCell",
                                      bundle: Bundle.mva10Billing),
                                forCellWithReuseIdentifier: "CurrentBillShimmerCell")
        collectionView.register(UINib(nibName: "PrevBillShimmerCell",
                                      bundle: Bundle.mva10Billing),
                                forCellWithReuseIdentifier: "PrevBillShimmerCell")

    }

    func registerCellHeaders() {
        collectionView.register(UINib(nibName: "BillingHeaderView", bundle: Bundle.mva10Billing),
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: "BillingHeader")
    }
}

// MARK: - datasource delegate
extension VFGBillsViewController: UICollectionViewDataSource {

    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return showChart ? 1 : 0
        case 1:
            return 1
        case 2:
            return numberOfRowsInSecondSection(recentBillsCount: recentBills.count)
        case 3:
            return numberOfRowsInThirdSection(recentBillsCount: recentBills.count)
        default:
            return 0
        }
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell {
            if indexPath.section == 0 {
                if let billingChartCollectionCell = billingChartCollectionCell {
                    return billingChartCollectionCell
                } else {
                    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChartCell", for: indexPath)
                    guard let cellItem = cell as? BillingChartCollectionCell else {
                        return cell
                    }
                    guard !recentBills.isEmpty, let currentBill = currentBill else { return cell }
                    var totalBills = recentBills
                    totalBills.insert(currentBill, at: 0)
                    cellItem.delegate = self
                    cellItem.configure(dashboardList: totalBills)
                    billingChartCollectionCell = cell as? BillingChartCollectionCell
                    return cell
                }
            } else if indexPath.section == 1 {
                return getCurrentBillSectionCell()
            } else if indexPath.section == 2 {
                return getPreviousBillSectionCell(indexPath: indexPath)
            } else if indexPath.section == 3 {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowMoreCell", for: indexPath)
                guard let cellItem = cell as? ShowMoreCell else {
                    return cell
                }
                cellItem.showMoreAction = {
                    self.showMorePressed = true
                    self.collectionView.reloadData()
                }
                cellItem.configureUI(title: "billing_show_more_title".localized(bundle: Bundle.mva10Billing),
                                     recentBillCount: recentBills.count,
                                     monthsCounter: monthsCounter)
                return cell
            }
            return UICollectionViewCell()
    }

    public func collectionView(_ collectionView: UICollectionView,
                               viewForSupplementaryElementOfKind kind: String,
                               at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let billingHeaderView = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: "BillingHeader",
                for: indexPath) as? BillingHeaderView else {
                    fatalError("Unexpected element kind")
            }
            var formattedDate: String?
            if let dateStr = currentBill?.outOfBundleAmount.first?.date {
                formattedDate = DateHelper.changeDateStringFormat(dateString: dateStr,
                                                                  format: "dd MMM",
                                                                  dateFormatString: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ")
            }
            if indexPath.section == 1 {
                billingHeaderView.titleLabel.text = "billing_current_bill_title".localized(bundle: Bundle.mva10Billing)
                if let date = formattedDate {
                    let localized = "billing_credit_card_paid_date".localized(bundle: Bundle.mva10Billing)
                    let localizedString = String(format: localized, "\(date)", "", "")
                    billingHeaderView.detailLabel.text =  localizedString
                } else {
                    billingHeaderView.detailLabel.text =  ""
                }
            } else if indexPath.section == 2 {
                billingHeaderView.titleLabel.text = "billing_previous_bill_title".localized(bundle: Bundle.mva10Billing)
                billingHeaderView.detailLabel.text = ""
            }
            return billingHeaderView

        default:
            fatalError("Unexpected element kind")
        }
    }

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                               referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize.zero
        } else if section == 2 {
            return recentBills.isEmpty ? CGSize.zero : defaultSection2Size
        } else if section == 3 {
            return defaultSection3Size
        }
        return defaultSectionSize
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

// MARK: - previous bill cells
extension VFGBillsViewController {
    func getPreviousBillSectionCell(indexPath: IndexPath) -> UICollectionViewCell {
        return startPreviousAndCurrentShimmerAnimation ?
               getPreviousBillShimmerCell() : getPreviousBillCell(indexPath: indexPath)
    }

    func getPreviousBillShimmerCell() -> UICollectionViewCell {
        let currentCellIndexPath = IndexPath(item: 0, section: 1)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrevBillShimmerCell",
                                                      for: currentCellIndexPath)
        guard let cellItem = cell as? PrevBillShimmerCell else {
            return cell
        }
        cell.isUserInteractionEnabled = false
        cellItem.startShimmer()
        return cellItem
    }

    func getPreviousBillCell(indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PrevBillCell",
                                                      for: indexPath)
        guard let cellItem = cell as? PrevBillCollectionCell else {
            return cell
        }
        cellItem.configure(data: !recentBills.isEmpty ? recentBills[indexPath.row] : nil)
        return cell
    }
}

// MARK: - current bill cell
extension VFGBillsViewController {
    func getCurrentBillSectionCell() -> UICollectionViewCell {
        return startPreviousAndCurrentShimmerAnimation ?
            getCurrentBillShimmerCell() : getCurrentBillCell()
    }

    func getCurrentBillShimmerCell() -> UICollectionViewCell {
        let indexPath = IndexPath(item: 0, section: 1)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentBillShimmerCell",
                                                      for: indexPath)
        guard let cellItem = cell as? CurrentBillShimmerCell else {
            return cell
        }
        cell.isUserInteractionEnabled = false
        cellItem.startShimmer()
        return cellItem
    }

    func getNegativeBillCell() -> UICollectionViewCell {
        let negativeCellIndexPath = IndexPath(item: 0, section: 1)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NegativeBillCell",
                                                      for: negativeCellIndexPath)
        guard let cellItem = cell as? NegativeBillCollectionCell else {
            return cell
        }
        cellItem.configure(data: currentBill)
        cellItem.delegate = self
        return cellItem
    }

    func getNegativeBillCellPDF() -> UICollectionViewCell {
        let negativeCellIndexPath = IndexPath(item: 0, section: 1)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NegativeBillPDFCell",
                                                      for: negativeCellIndexPath)
        guard let cellItem = cell as? NegativeBillPDFCell else {
            return cell
        }
        cellItem.configure(data: currentBill)
        cellItem.delegate = self
        return cellItem
    }

    func getCurrentBillCollectionCell() -> UICollectionViewCell {
        let currentCellIndexPath = IndexPath(item: 0, section: 1)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentBillCell",
                                                      for: currentCellIndexPath)
        guard let cellItem = cell as? CurrentBillCollectionCell else {
            return cell
        }
        cellItem.configure(data: currentBill)
        return cellItem
    }

    func getCurrentBillPDFCell() -> UICollectionViewCell {
        let currentCellIndexPath = IndexPath(item: 0, section: 1)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CurrentBillPDFCell",
                                                      for: currentCellIndexPath)
        guard let cellItem = cell as? CurrentBillPDFCell else {
            return cell
        }
        cellItem.configure(data: currentBill)
        cellItem.delegate = self
        return cellItem
    }

    func getCurrentBillCell() -> UICollectionViewCell {
        if VFGBillingManager.shared.dataProvider?.enableCurrentPDFCell ?? false {
            if (currentBill?.amountDue?.value ?? 0.0) >= 0.0 {
                return getCurrentBillPDFCell()
            } else {
                return getNegativeBillCellPDF()
            }
        } else {
            if (currentBill?.amountDue?.value ?? 0.0) >= 0.0 {
                return getCurrentBillCollectionCell()
            } else {
                return getNegativeBillCell()
            }
        }
    }
}

extension VFGBillsViewController: UICollectionViewDelegateFlowLayout {

    func estimateCurrentBillCellHeight() -> CGFloat {
        let bundleViewHeight = 30
        return CGFloat((currentBill?.outOfBundleAmount.count ?? 0) * bundleViewHeight)
    }

    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case 0:
            return CGSize(width: UIScreen.main.bounds.width, height: 200)
        case 1:
            var currentCellHeight: CGFloat = 0
            if VFGBillingManager.shared.dataProvider?.enableCurrentPDFCell ?? false {
                currentCellHeight = VFGMVA10BillingConstants.currentCellHeightWithPDF
            } else {
                currentCellHeight = VFGMVA10BillingConstants.currentCellHeight
            }
            return CGSize(width: UIScreen.main.bounds.width - 32,
                          height: currentCellHeight + estimateCurrentBillCellHeight())
        case 3:
        return CGSize(width: UIScreen.main.bounds.width, height: 48)
        default:
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 166)
        }
    }
}
