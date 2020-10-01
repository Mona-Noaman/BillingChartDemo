//
//  NegativeBalanceInfoViewModel.swift
//  VFGMVA10Billing
//
//  Created by Ahmed Sultan on 6/9/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import VFGFoundation
// MARK: - Quick Action operations
class NegativeBalanceInfoViewModel: VFQuickActionsModel {
    weak var quickActionDelegate: VFQuickActionsProtocol?
    weak var infoConfirmAlertDelegate: VFGInfoConfirmationAlertDelegate?

    init(infoConfirmAlertDelegate: VFGInfoConfirmationAlertDelegate?) {
        self.infoConfirmAlertDelegate = infoConfirmAlertDelegate
    }

    var quickActionsStyle: VFQuickActionsStyle {
        return .white
    }
    var quickActionsTitle: String {
        return "billing_negative_bill_quick_action_title".localized(bundle: Bundle.mva10Billing)
    }

    var quickActionsContentView: UIView {
        guard let confirmationView: VFGInfoConfirmationAlert = VFGInfoConfirmationAlert
            .loadXib(bundle: Bundle.foundation) else {
                return UIView()
        }
        confirmationView.delegate = infoConfirmAlertDelegate
        confirmationView.model = VFGInfoConfirmationAlertModel(infoIconName: "icInfoCircleHi",
                                                               infoQuestion:
            "billing_negative_bill_quick_action_question_text"
                .localized(bundle: Bundle.mva10Billing),
                                                               infoAnswer:
            "billing_negative_bill_quick_action_description"
                .localized(bundle: Bundle.mva10Billing),
                                                               confimButtonTitle:
            "billing_negative_bill_quick_action_button_text"
                                                                .localized(bundle: Bundle.mva10Billing))

        return confirmationView
    }

    func quickActionsProtocol(delegate: VFQuickActionsProtocol) {
        quickActionDelegate = delegate
    }

    func closeQuickAction() {
        quickActionDelegate?.closeQuickAction()
    }
}
