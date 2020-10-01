//
//  VFGBillsViewController+PDFCellAction.swift
//  VFGMVA10Billing
//
//  Created by Moustafa Hegazy on 5/19/20.
//

import Foundation
import VFGFoundation

extension VFGBillsViewController: CurrentBillPDFDelegate {

    // negative bill
    func negativeInfoButtonPressed() {
        VFQuickActionsViewController.presentQuickActionsViewController(with: negativeBalanceInfoViewModel)
    }

    func detailButtonPressed() {
        // MARK: Here to check bill status in PDF Cell
        if let bill = currentBill {
            setupDetailsView(selectedBill: bill, actionButtonType: .toBePaid)
        }
    }

    func pdfButtonPressed() {
        let selectedIndex = getSelectedIndex(indexPath: selectedIndexPath)
        let selectedViewController = VFGBillingManager.shared.dataProvider?.pdfButtonPressed(at: selectedIndex)
            ?? UIViewController()
        let localized = "billing_dashboard_title".localized(bundle: Bundle.mva10Billing)
        if let mva10NavigationController = navigationController as?
            MVA10NavigationController {
            mva10NavigationController.setTitle(title: localized, for: selectedViewController)
        } else {
            let attributes = [NSAttributedString.Key.font: UIFont.vodafoneRegular(19.0),
                              .foregroundColor: UIColor.VFGPrimaryText]
            navigationController?.topViewController?.title = localized
            navigationController?.navigationBar.titleTextAttributes = attributes
        }
        navigationController?.pushViewController(selectedViewController, animated: true)
    }

    func getSelectedIndex(indexPath: IndexPath?) -> IndexPath {
        if let selectedIndex = indexPath {
            return selectedIndex
        } else {
            return IndexPath(row: 0, section: 1)
        }
    }
}

// MARK: - VFGConfirmationAlertDelegate
extension VFGBillsViewController: VFGInfoConfirmationAlertDelegate {
    public func confirmActionPressed(completion: (() -> Void)?) {
        negativeBalanceInfoViewModel.closeQuickAction()
    }
}
