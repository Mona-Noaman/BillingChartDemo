//
//  ChartBarCell.swift
//  VFGMVA10Billing
//
//  Created by Hussein Kishk on 5/31/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

class ChartBarCell: UICollectionViewCell {

    @IBOutlet weak var barBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var barViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var barBillDescriptionView: UIView!
    @IBOutlet weak var barBillMonthLabel: UILabel!
    @IBOutlet weak var barBillCostLabel: UILabel!
    @IBOutlet weak var barBillMonthPeriod: UILabel!
    @IBOutlet weak var barbillYearLabel: UILabel!
    @IBOutlet weak var seeBillButton: UIButton!

    weak var delegate: ChartViewDelegate?
    var selectedRow = 0
    var totalBarsCount = 0
    var isDecember = false
    var currentBillHasNegativeValue = false
    var isExpanded = false
    var shouldAnimate: Bool?
    override func awakeFromNib() {
        super.awakeFromNib()
        barView.layer.cornerRadius = 4
        barViewHeightConstraint.constant = 0
        barbillYearLabel.transform = CGAffineTransform(rotationAngle: CGFloat(( -90 * Double.pi ) / 180))
        seeBillButton.setTitle("billing_chart_see_bill".localized(bundle: Bundle.mva10Billing), for: .normal)
        barBillCostLabel.font = .vodafoneBold(16)
    }

    fileprivate func animateBars(_ bar: Bar, _ row: Int, _ barHeight: Double) {
        guard !barHeight.isNaN, !bar.info.isEmpty else {
            barViewHeightConstraint.constant = 0
            return
        }
        if shouldAnimate ?? false {
            let delay = VFGMVA10BillingConstants.totalBarsAnimationDelay - (Double(row)/40)
            barViewHeightConstraint.constant = 0
            DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
                UIView.animate(withDuration:
                TimeInterval(VFGMVA10BillingConstants.singleBarHeightDuration)) { [weak self] in
                    guard let self = self else { return }
                    if self.currentBillHasNegativeValue {
                        self.barViewHeightConstraint.constant = VFGMVA10BillingConstants.barViewHeight
                        self.barView.layer.cornerRadius = 4
                    } else {
                        if barHeight == 0 {
                            self.barViewHeightConstraint.constant = 2
                            self.barView.layer.cornerRadius = 0
                        } else {
                            self.barViewHeightConstraint.constant = CGFloat(barHeight)
                            self.barView.layer.cornerRadius = 4
                        }
                    }
                    self.layoutIfNeeded()
                }
            }
        } else {
            if currentBillHasNegativeValue {
                barViewHeightConstraint.constant = VFGMVA10BillingConstants.barViewHeight
                barView.layer.cornerRadius = 4
            } else {
                if barHeight == 0 {
                    barViewHeightConstraint.constant = 2
                    barView.layer.cornerRadius = 0
                } else {
                    barViewHeightConstraint.constant = CGFloat(barHeight)
                    barView.layer.cornerRadius = 4
                }
            }
        }
    }

    func setupBillingPeriodLabel(_ bar: Bar) {
        switch delegate?.billingPeriodFormat {
        case .custom(let format):
            barBillMonthPeriod.text = setCustomFormat(startDate: bar.startDateTime,
                                                      endDate: bar.endDateTime,
                                                      format: format)
        case .noPeriod, .none:
            barBillMonthPeriod.text = ""
        }
    }

    func configure(bar: Bar,
                   maxBarHeightValue: Double,
                   row: Int,
                   totalBarsCount: Int,
                   billsHaveNegativeValue: Bool) {
        currentBillHasNegativeValue = bar.value < 0.0
        self.totalBarsCount = totalBarsCount
        selectedRow = row
        barBillMonthLabel.text = bar.title
        barBillCostLabel.text = bar.info
        setupBillingPeriodLabel(bar)
        let barHeight = bar.value * 100 / maxBarHeightValue

        if billsHaveNegativeValue {
            if currentBillHasNegativeValue {
                barBottomConstraint.constant = VFGMVA10BillingConstants.lastRowBarBottomConstraint
            } else {
                barBottomConstraint.constant = VFGMVA10BillingConstants.barBottomConstraint
            }
        } else {
            barBottomConstraint.constant = VFGMVA10BillingConstants.lastRowBarBottomConstraint
        }

        animateBars(bar, row, barHeight)
        if bar.billMonthID == VFGMVA10BillingConstants.decemberId, row != (totalBarsCount - 1) {
            barbillYearLabel.isHidden = false
            let yearAsInt = Int(bar.billYear) ?? 0
            let yearToBeViewed = yearAsInt + 1
            barbillYearLabel.text = "\(yearToBeViewed)"
            isDecember = true
        } else {
            barbillYearLabel.isHidden = true
            isDecember = false
        }
    }

    @IBAction func seeBillButtonPressed(_ sender: Any) {
        delegate?.seeBillButtonPressed(selectedRowInRecentBills: (totalBarsCount - selectedRow - 1))
    }

    func setCustomFormat(startDate: String, endDate: String, format: String) -> String {
        return DateHelper.getDateIntervalFromISO8601Date(startDate: startDate, endDate: endDate, format: format)
    }
}
