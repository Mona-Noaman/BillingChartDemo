//
//  BillItemCell.swift
//  VFGBilling
//
//  Created by Mert Karabulut on 16.12.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit
import VFGFoundation

protocol BillItemCellDelegate: class {
    func showMoreButtonPressedAtIndex(_ atIndex: Int)
}

class BillItemCell: UITableViewCell {
    weak var delegate: BillItemCellDelegate?

    @IBOutlet weak var viewContainer: UIView!

    @IBOutlet weak var imageViewBillItem: UIImageView!
    @IBOutlet weak var labelBillItemTitle: VFGLabel!
    @IBOutlet weak var labelBillItemSubtitle: VFGLabel!

    @IBOutlet weak var stackViewContainer: UIStackView!

    @IBOutlet weak var labelTotal: VFGLabel!
    @IBOutlet weak var labelTotalValue: VFGLabel!
    @IBOutlet weak var labelOutOfService: VFGLabel!
    @IBOutlet weak var labelOutOfServiceValue: VFGLabel!

    @IBOutlet weak var viewOutOfServiceCostList: UIView!
    @IBOutlet weak var stackViewOutOfService: UIStackView!

    @IBOutlet weak var viewProductList: UIView!
    @IBOutlet weak var stackViewProduct: UIStackView!

    @IBOutlet weak var viewVAT: UIView!
    @IBOutlet weak var labelTotalBeforeVAT: VFGLabel!
    @IBOutlet weak var labelTotalBeforeVATValue: VFGLabel!
    @IBOutlet weak var labelVAT: VFGLabel!
    @IBOutlet weak var labelVATValue: VFGLabel!

    @IBOutlet weak var buttonShowMore: UIButton!

    var index: Int = -1

    override func awakeFromNib() {
        super.awakeFromNib()

        viewContainer.configureShadow()

        labelTotal.text =
            "billing_payment_breakdown_total_pay_title".localized(bundle: Bundle.mva10Billing)
        labelOutOfService.text =
            "billing_payment_breakdown_service_cost_title".localized(bundle: Bundle.mva10Billing)
        labelTotalBeforeVAT.text =
            "billing_payment_breakdown_total_before_vat_title".localized(bundle: Bundle.mva10Billing)
        labelVAT.text =
            "billing_payment_breakdown_vat_title".localized(bundle: Bundle.mva10Billing)

        imageViewBillItem.tintColor = .VFGGreyTint
        clearAndCollapseItems()
    }

    // MARK: - Actions
    @IBAction func showMoreButtonPressed(_ sender: Any) {
        if let delegate = delegate {
            delegate.showMoreButtonPressedAtIndex(self.index)
        }
    }
}

extension BillItemCell {
    final func configure(subscription: Subscription, index: Int) {
        clearAndCollapseItems()
        self.index = index

        updateLabels(subscription: subscription)

        if let outOfBundleList = subscription.outOfAmounts, !outOfBundleList.isEmpty {
            viewOutOfServiceCostList.isHidden = false
            for bundle in outOfBundleList {
                guard let view: BillCostView = BillCostView.loadXib(bundle: Bundle.mva10Billing) else {
                    return
                }
                view.configure(billDetailItem: bundle)
                stackViewOutOfService.addArrangedSubview(view)
            }
        } else {
            viewOutOfServiceCostList.isHidden = true
        }

        if let productList = subscription.products, !productList.isEmpty {
            viewProductList.isHidden = false
            for product in productList {
                guard let view: BillServiceItemView = BillServiceItemView.loadXib(bundle: Bundle.mva10Billing) else {
                    return
                }
                view.configure(billDetailItem: product)
                stackViewProduct.addArrangedSubview(view)
            }
        } else {
            viewProductList.isHidden = true
        }

        viewVAT.isHidden = false

        if subscription.isExpanded == true {
            if let outOfBundleList = subscription.outOfAmounts, !outOfBundleList.isEmpty {
                viewOutOfServiceCostList.isHidden = false
            } else {
                viewOutOfServiceCostList.isHidden = true
            }

            if let productList = subscription.products, !productList.isEmpty {
                viewProductList.isHidden = false
            } else {
                viewProductList.isHidden = true
            }

            viewVAT.isHidden = false
            buttonShowMore.setTitle("billing_payment_breakdown_btn_hide_details".localized(bundle: Bundle.mva10Billing),
                                    for: .normal)
        } else {
            viewOutOfServiceCostList.isHidden = true
            viewProductList.isHidden = true
            viewVAT.isHidden = true
            buttonShowMore.setTitle("billing_payment_breakdown_btn_show_details".localized(bundle: Bundle.mva10Billing),
                                    for: .normal)
        }
    }

    func updateLabels(subscription: Subscription) {
        labelBillItemTitle.text = subscription.name

        if subscription.isBundle == true {
            imageViewBillItem.image = UIImage(named: "icFamily", in: Bundle.mva10Billing, compatibleWith: nil)
            labelBillItemSubtitle.text = "billing_details_bundle".localized(bundle: Bundle.mva10Billing)
            labelBillItemSubtitle.isHidden = false
        } else {
            imageViewBillItem.image = UIImage(named: "icMobile", in: Bundle.mva10Billing, compatibleWith: nil)
            labelBillItemSubtitle.isHidden = true
        }

        labelTotalValue.text = subscription.totalPayAmount
        labelOutOfServiceValue.text = subscription.totalOutOfAmount
        labelTotalBeforeVATValue.text = subscription.totalBeforeVAT?.localValue
        labelVATValue.text = subscription.totalVAT?.localValue
    }

    final private func clearAndCollapseItems() {
        stackViewOutOfService.removeAllArrangedSubviews()
        viewOutOfServiceCostList.isHidden = true
        stackViewProduct.removeAllArrangedSubviews()
        viewProductList.isHidden = true
        viewVAT.isHidden = true
        buttonShowMore.setTitle("billing_details_title".localized(bundle: Bundle.mva10Billing), for: .normal)
    }
}
