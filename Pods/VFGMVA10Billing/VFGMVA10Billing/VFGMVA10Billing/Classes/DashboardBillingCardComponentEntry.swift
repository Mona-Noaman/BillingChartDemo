//
//  DashboardBillingCardComponentEntry.swift
//  VFGMVA10Group
//
//  Created by Mohamed Mahmoud Zaki on 4/7/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation
import VFGFoundation

public class DashboardBillingCardComponentEntry: NSObject, VFGComponentEntry, BillingViewModelDelegate {
    var viewModel: BillingViewModel?
    var view: DashboardBillingCard?

    public required init(config: [String: Any]?, error: [String: Any]?) {
        super.init()

        view = DashboardBillingCard.loadXib(bundle: Bundle.mva10Billing) ?? DashboardBillingCard()
        view?.accessibilityIdInitial = config?["automationId"] as? String

        if let errorMessage = error?["errorMessage"] as? String {
            view?.showErrorMessage(errorMessage: errorMessage)
        } else {
            if let provider = VFGBillingManager.shared.dataProvider {
                viewModel = BillingViewModel(dataProvider: provider)
                VFGBillingManager.shared.billingViewModel = viewModel
                viewModel?.delegate = self
                viewModel?.loadBalanceData()
            }
        }
    }

    public var cardView: UIView? {
        return view
    }

    public var cardEntryViewController: UIViewController? {
        return nil
    }

    public func didSelectCard() {
        let mvaNavigationController = VFGBillingManager.shared.navigationController()
        mvaNavigationController.modalPresentationStyle = .fullScreen
        UIApplication.topViewController()?.present(mvaNavigationController, animated: true, completion: nil)
    }

    public func handleViewModelOutput(_ output: BillingViewModelOutput) {
        if case .updateBalance(let model) = output {
            (cardView as? DashboardBillingCard)?.configure(model: model?.bill)
        }
    }
}
