//
//  VFGBillingManager.swift
//  Pods
//
//  Created by Moseley, Jack, Vodafone Group on 13/03/2020.
//

import UIKit
import VFGFoundation

public class VFGBillingManager {
    public static let shared = VFGBillingManager()

    public var dataProvider: VFGBillingDataProviderProtocol?

    public var billingViewModel: BillingViewModel?

    private init() {}

    public func navigationController() -> UINavigationController {
        let billVC = UIStoryboard(name: "Billing",
                                  bundle: Bundle.mva10Billing)
            .instantiateViewController(withIdentifier: "BillsViewController")

        guard let billingViewController = billVC as? VFGBillsViewController,
            let viewModel = billingViewModel else {
                return UINavigationController()
        }
        billingViewController.viewModel = viewModel
        let mvaNavigationController = MVA10NavigationController(rootViewController: billingViewController)
        return mvaNavigationController
    }
}
