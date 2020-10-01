//
//  BillingDetailViewController.swift
//  VFGBilling
//
//  Created by Mert Karabulut on 17.12.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit
import VFGFoundation

public class BillingDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var billTitleLabel: VFGLabel!
    @IBOutlet var billAmountLabel: VFGLabel!
    @IBOutlet var titleShimmerView: ShimmerView!
    @IBOutlet var amountShimmerView: ShimmerView!

    let sectionHeaderHeight: CGFloat = 64
    private let billItemCellID = "BillItemCell"
    private let billSummaryCellID = "BillSummaryCell"
    private let billPageHeaderViewID = "BillPageHeaderView"
    private let billPageSectionHeaderViewID = "BillPageSectionHeaderView"
    private let billPageHeaderShimmerCell = "BillPageHeaderShimmerCell"
    private let billSummaryShimmerCell = "BillSummaryShimmerCell"
    private let billItemShimmerCell = "BillItemShimmerCell"

    var billDetail: BillDetailModelProtocol?
    var subscriptions: [Subscription]?
    var appliedPayments: [BillAppliedPayment]?

    var startShimmerAnimation = true
    let sectionFooterHeight: CGFloat = 1
    let helpViewBottomCInset: CGFloat = 87
    var actionButtonType: ActionButtonType?

    public var viewModel: BillingDetailViewModelProtocol! {
        didSet {
            viewModel.delegate = self
        }
    }

    public override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        registerCells()
    }

    private func setupUI() {
        view.backgroundColor = .VFGVeryLightGreyBackground
        tableView?.rowHeight = UITableView.automaticDimension
        tableView?.sectionHeaderHeight = UITableView.automaticDimension
        tableView?.estimatedSectionHeaderHeight = sectionHeaderHeight
        tableView?.sectionFooterHeight = sectionFooterHeight
        tableView?.tableFooterView = UIView(frame: CGRect.zero)

        tableView?.contentInset.bottom += helpViewBottomCInset
        tableView?.isScrollEnabled = false
        tableView?.backgroundColor = .clear
        setupTitleShimmer()
    }

    private func registerCells() {
        tableView.register(UINib(nibName: "BillItemCell", bundle: Bundle.mva10Billing),
                           forCellReuseIdentifier: billItemCellID)
        tableView.register(UINib(nibName: "BillSummaryCell", bundle: Bundle.mva10Billing),
                           forCellReuseIdentifier: billSummaryCellID)
        tableView.register(UINib(nibName: "BillPageHeaderView", bundle: Bundle.mva10Billing),
                           forHeaderFooterViewReuseIdentifier: billPageHeaderViewID)
        tableView.register(UINib(nibName: "BillPageSectionHeaderView", bundle: Bundle.mva10Billing),
                           forHeaderFooterViewReuseIdentifier: billPageSectionHeaderViewID)
        tableView.register(UINib(nibName: "BillPageHeaderShimmerCell", bundle: Bundle.mva10Billing),
                           forHeaderFooterViewReuseIdentifier: billPageHeaderShimmerCell)
        tableView.register(UINib(nibName: "BillSummaryShimmerCell", bundle: Bundle.mva10Billing),
                           forCellReuseIdentifier: billSummaryShimmerCell)
        tableView.register(UINib(nibName: "BillItemShimmerCell", bundle: Bundle.mva10Billing),
                           forCellReuseIdentifier: billItemShimmerCell)

    }
}

extension BillingDetailViewController: BillingDetailViewModelDelegate {

    public func handleViewModelOutput(_ output: BillingDetailViewModelOutput) {
        switch output {
        case .updateBillingDetail(let billDetail, _):
            tableView?.isScrollEnabled = true
            startShimmerAnimation = false
            if billDetail != nil {
                self.billDetail = billDetail
                self.subscriptions = billDetail?.subscription
                self.appliedPayments = billDetail?.appliedPayment
                updateTitleDetails()
                self.tableView?.reloadData()
            } else {
                backButtonPressed()
            }
        case .showBillDetailsShimmer:
            startShimmerAnimation = true
        }
    }
}

extension BillingDetailViewController {
    func setupTitleShimmer() {
        billTitleLabel.isHidden = true
        billAmountLabel.isHidden = true
        titleShimmerView.startAnimation()
        amountShimmerView.startAnimation()
    }

    func updateTitleDetails() {
        billTitleLabel.text = billDetail?.billStartEndDate
        billAmountLabel.text = billDetail?.amountDue.localValue
        if let amount = billDetail?.amountDue.value {
            billAmountLabel.textColor = amount >= 0 ? .VFGPrimaryText : .VFGRedOrangeText
        }
        billTitleLabel.isHidden = false
        billAmountLabel.isHidden = false
        titleShimmerView.removeFromSuperview()
        amountShimmerView.removeFromSuperview()
    }
}

extension BillingDetailViewController: BillPageHeaderViewDelegate {
    func backButtonPressed() {
        navigationController?.popViewController(animated: true)
    }

    func closeButtonPressed() {
        guard let navigationController = navigationController else {
            dismiss(animated: true, completion: nil)
            return
        }
        navigationController.dismiss(animated: true, completion: nil)
    }
}

extension BillingDetailViewController: BillItemCellDelegate {
    func showMoreButtonPressedAtIndex(_ atIndex: Int) {
        if let subscription = subscriptions?[atIndex] {
            let isExpanded: Bool = (subscription.isExpanded ?? false)
            var modifiedSubscription: Subscription = subscription
            modifiedSubscription.isExpanded = !isExpanded
            subscriptions?[atIndex] = modifiedSubscription
        }
        self.tableView?.reloadSections([1], with: .fade)
    }
}
