//
//  VFGBillViewController.swift
//  VFGMVA10Group
//
//  Created by Samet MACİT on 25.11.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import VFGFoundation

public class VFGBillsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint?
    @IBOutlet var noBillTitle: UILabel!
    @IBOutlet var noBillSubTitle: UILabel!
    @IBOutlet var noBillsIcon: UIImageView!
    lazy var negativeBalanceInfoViewModel: VFQuickActionsModel = {
        NegativeBalanceInfoViewModel(infoConfirmAlertDelegate: self)
    }()
    var activityView = UIActivityIndicatorView(style: .gray)
    var startPreviousAndCurrentShimmerAnimation = true
    var billingChartCollectionCell: BillingChartCollectionCell?

    let defaultSection2Size = CGSize(width: UIScreen.main.bounds.width - 32, height: 75)
    let defaultSection3Size = CGSize(width: UIScreen.main.bounds.width - 32, height: 16)
    let defaultSectionSize = CGSize(width: UIScreen.main.bounds.width, height: 75)
    var currentBill: HistoryModelProtocol?
    var recentBills: [HistoryModelProtocol] = [] {
        didSet {
            showChart = recentBills.count >= 1
        }
    }

    var showChart = true

    private var mva10navigationController: MVA10NavigationController?

    var showMorePressed = false

    var preMonthsCount = 11
    var monthsCounter = 0
    var selectedIndexPath: IndexPath?
    weak var currentCellDelegate: CurrentBillPDFDelegate?

    private var isMVA10navigationController: Bool {
        if let mva10NavC = navigationController as?
            MVA10NavigationController {
            mva10navigationController = mva10NavC
            return true
        }
        return false
    }

    public var viewModel: BillingViewModelProtocol! {
        didSet {
            viewModel.delegate = self
            viewModel.loadHistoryData()
            collectionView?.reloadData()
        }
    }

     func createPinTextLabel() -> UILabel {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        label.backgroundColor = UIColor.red
        label.layer.cornerRadius = 8
        label.textColor = .white
        label.layer.masksToBounds = true
        label.font = UIFont.systemFont(ofSize: 13)
        label.textAlignment = .center
        return label
    }

    lazy var pinText: UILabel = {
        return createPinTextLabel()
    }()

    var pageTitle = "billing_landing_title".localized(bundle: Bundle.mva10Billing)

    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if let height = self.navigationController?.navigationBar.frame.height {
            collectionViewTopConstraint?.constant = height
        }
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .VFGVeryLightGreyBackground
        if currentCellDelegate == nil {
            currentCellDelegate = self
        }
        configureCollectionView()
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if isMVA10navigationController {
            navigationController?.setNavigationBarHidden(true, animated: animated)
            mva10navigationController?.setTitle(title: pageTitle, for: self)
            mva10navigationController?.hasDivider = false
        } else {
            let attributes = [NSAttributedString.Key.font: UIFont.vodafoneRegular(19.0),
                              .foregroundColor: UIColor.VFGPrimaryText]
            self.navigationController?.topViewController?.title = pageTitle
            self.navigationController?.navigationBar.titleTextAttributes = attributes
        }
    }

    func configureCollectionView() {
        collectionView?.isScrollEnabled = false
        collectionView?.backgroundColor = .clear
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.bounces = false
        registerCells()
        registerCellHeaders()
    }

    func checkCurrentBillAvailable(currentBillAmount: Double?) {
        if currentBillAmount == nil {
            setupNoBillViews(paymentDate: currentBill?.billDate ?? "")
            showNoBillViews()
        } else {
            hideNoBillViews()
        }
    }

    private func setupNoBillViews(paymentDate: String) {
        noBillTitle.text = "billing_no_bill_title".localized(bundle: Bundle.mva10Billing)
        noBillSubTitle.text = DateHelper.getFormattedDate(paymentDate: paymentDate,
                                                          dateFormatString: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",
                                                          localizedKey: "billing_no_bill_subtitle")
    }

    private func showNoBillViews() {
        collectionView.isHidden = true
        showChart = false
        noBillTitle.isHidden = false
        noBillSubTitle.isHidden = false
        noBillsIcon.isHidden = false
    }

    private func hideNoBillViews() {
        collectionView.isHidden = false
        showChart = true
        noBillTitle.isHidden = true
        noBillSubTitle.isHidden = true
        noBillsIcon.isHidden = true
    }
}

extension VFGBillsViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        var selectedBill: HistoryModelProtocol?
        var buttonType: ActionButtonType?
        switch indexPath.section {
        case 1:
            // MARK: Here to check bill status
            buttonType = .toBePaid
            if let bill = currentBill {
                selectedBill = bill
            }
            if VFGBillingManager.shared.dataProvider?.enableCurrentPDFCell ?? false {
                selectedIndexPath = indexPath
                return
            }
        case 2:
            buttonType = .paid
            selectedBill = recentBills[indexPath.row]
        default:
            return
        }
        setupDetailsView(selectedBill: selectedBill, actionButtonType: buttonType)
    }

    func setupDetailsView(selectedBill: HistoryModelProtocol?, actionButtonType: ActionButtonType?) {
        guard let dataProvider = VFGBillingManager.shared.dataProvider else {
            return
        }
        if selectedBill != nil {
            let billDetailVC = BillingDetailViewController.instance()
            let billingDetailViewController: BillingDetailViewController = billDetailVC

            billingDetailViewController.viewModel = BillingDetailViewModel(dataProvider:
                dataProvider, billId: selectedBill!.historyId)
            billingDetailViewController.viewModel.setup()
            billingDetailViewController.actionButtonType = actionButtonType
            if let billDate = selectedBill?.billDate {
                let month = DateHelper.getMonthFromISO8601Date(dateString: billDate,
                                                               dateFormatString: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ")
                let localized = "billing_details_title".localized(bundle: Bundle.mva10Billing)
                let localizedString = String(format: localized, "\(String(describing: month))")
                if isMVA10navigationController {
                    mva10navigationController?.setTitle(title: localizedString, for: billDetailVC)
                } else {
                    let attributes = [NSAttributedString.Key.font: UIFont.vodafoneRegular(19.0),
                                      .foregroundColor: UIColor.VFGPrimaryText]
                    self.navigationController?.topViewController?.title = localizedString
                    self.navigationController?.navigationBar.titleTextAttributes = attributes
                }
            }
            pushBillingDetailViewController(billingDetailViewController: billingDetailViewController)
        }
    }

    @objc func pushBillingDetailViewController(billingDetailViewController: BillingDetailViewController) {
        navigationController?.pushViewController(billingDetailViewController, animated: true)
    }
}

extension VFGBillsViewController: BillingViewModelDelegate {

    public func handleViewModelOutput(_ output: BillingViewModelOutput) {
        switch output {
        case .updateBills(let current, let recentBills):
            if let currentBill = current {
                self.currentBill = currentBill
                checkCurrentBillAvailable(currentBillAmount: self.currentBill?.amountDue?.value)
            }
            if let bills = recentBills {
                self.recentBills = bills
            }
            startPreviousAndCurrentShimmerAnimation = false
            collectionView?.isScrollEnabled = true
        case .shimmerPreviousAndCurrent:
            startPreviousAndCurrentShimmerAnimation = true
        default:
            return
        }
        collectionView?.reloadData()
    }
}

extension VFGBillsViewController: ChartHeaderDelegate {
    public func closeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}
