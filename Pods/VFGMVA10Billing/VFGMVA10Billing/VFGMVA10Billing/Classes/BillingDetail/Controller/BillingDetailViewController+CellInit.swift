//
//  BillingDetailViewController+CellInit.swift
//  VFGMVA10Billing
//
//  Created by Moustafa Hegazy on 5/13/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit
import VFGFoundation

public enum ActionButtonType {
    case toBePaid
    case paid
    case payOn
}

extension BillingDetailViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return appliedPayments?.count ?? 1
        case 1:
            return subscriptions?.count ?? 3
        default:
            return 0
        }
    }

    public func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func setupFirstSectionCell(indexPath: IndexPath) -> UITableViewCell {
        if startShimmerAnimation {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BillSummaryShimmerCell", for: indexPath)
            guard let cellItem = cell as? BillSummaryShimmerCell else {
                return cell
            }
            cellItem.startShimmer()
            return cellItem
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BillSummaryCell", for: indexPath)
            guard let cellItem = cell as? BillSummaryCell else {
                return cell
            }
            if let appliedPayments = appliedPayments {
                let item = appliedPayments[indexPath.row]
                cellItem.configure(billPayment: item,
                                   billId: billDetail?.billId ?? "",
                                   partyAccountId: billDetail?.partyAccount?.accountId ?? "",
                                   actionButtonType: actionButtonType)
            }
            return cellItem
        }
    }

    func setupSecondSectionCell(indexPath: IndexPath) -> UITableViewCell {
        if startShimmerAnimation {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BillItemShimmerCell", for: indexPath)
            guard let cellItem = cell as? BillItemShimmerCell else {
                return cell
            }
            cellItem.startShimmer()
            return cellItem
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "BillItemCell", for: indexPath)
            guard let cellItem = cell as? BillItemCell else {
                return cell
            }
            cellItem.delegate = self
            if let subscriptions = subscriptions {
                let item = subscriptions[indexPath.row]
                cellItem.configure(subscription: item, index: indexPath.row)
            }
            return cellItem
        }
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            return setupFirstSectionCell(indexPath: indexPath)
        case 1:
            return setupSecondSectionCell(indexPath: indexPath)
        default:
            return UITableViewCell()
        }
    }
}

extension BillingDetailViewController: UITableViewDelegate {

    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 1:
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "BillPageSectionHeaderView")
            guard let sectionHeader = header as? BillPageSectionHeaderView else {
                return header
            }
            return sectionHeader
        default:
            return nil
        }
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? CGFloat.leastNonzeroMagnitude : sectionHeaderHeight
    }
}
