//
//  NegativeBillCollectionCell.swift
//  VFGMVA10Billing
//
//  Created by Salma Ashour on 6/7/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

class NegativeBillCollectionCell: UICollectionViewCell {

    weak var delegate: CurrentBillPDFDelegate?

    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelMonth: UILabel!
    @IBOutlet weak var labelValue: UILabel!
    @IBOutlet weak var stackViewExtraCharges: UIStackView!
    @IBOutlet weak var seperatorViewOne: UIView!
    @IBOutlet weak var stackViewServices: UIStackView!
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var extraChargesView: UIView!
    @IBOutlet weak var extraChargesLabel: UILabel!
    @IBOutlet weak var servicesIncludedLabel: UILabel!
    @IBOutlet weak var overPaidAmountLabel: UILabel!
    @IBOutlet weak var negativeBalanceLabel: UILabel!
    @IBOutlet weak var overPaidBillLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.roundCorners()
        seperatorViewOne.backgroundColor = .VFGGreyDividerOne
        configureShadow()
        localizeLabels()
    }

    func localizeLabels() {
        extraChargesLabel.text = "billing_current_bill_extra_charges".localized(bundle: Bundle.mva10Billing)
        servicesIncludedLabel.text = "billing_current_bill_included_services".localized(bundle: Bundle.mva10Billing)
        negativeBalanceLabel.text = "billing_negative_value_note".localized(bundle: Bundle.mva10Billing)
        overPaidBillLabel.text = "billing_negative_over_paid".localized(bundle: Bundle.mva10Billing)
    }
    // Negative bill action sheet
    @IBAction func infoIconPressed(_ sender: Any) {
        delegate?.negativeInfoButtonPressed()
    }
}

extension NegativeBillCollectionCell {

    func configure(data: HistoryModelProtocol?) {
        guard let data = data else { return }
        if stackViewServices.arrangedSubviews.isEmpty {
            labelYear.text = data.billYear
            labelMonth.text = data.billMonth
            labelValue.text = data.amountDue?.localValue
            overPaidAmountLabel.text = data.remainingAmount?.localValue

            loadExtraServices(outOfBundles: data.outOfBundleAmount)
            loadIncludedServices()
        }
    }

    func loadExtraServices(outOfBundles: [OutOfBundleAmount]) {
        if !outOfBundles.isEmpty {
            for amount in outOfBundles {
                let name = amount.characteristic.compactMap({$0.value}).joined(separator: " ")
                let bundleView = UIView()
                bundleView.translatesAutoresizingMaskIntoConstraints = false
                bundleView.heightAnchor.constraint(equalToConstant: 30).isActive = true
                stackViewExtraCharges.addArrangedSubview(bundleView)
                let titleLabel = UILabel()
                titleLabel.font = UIFont.vodafoneRegular(16)
                titleLabel.textColor = .VFGPrimaryText
                bundleView.addSubview(titleLabel)
                titleLabel.text = name
                titleLabel.translatesAutoresizingMaskIntoConstraints = false
                titleLabel.bottomAnchor.constraint(equalTo: bundleView.bottomAnchor, constant: 0).isActive = true
                titleLabel.topAnchor.constraint(equalTo: bundleView.topAnchor, constant: 0).isActive = true
                titleLabel.leadingAnchor.constraint(equalTo: bundleView.leadingAnchor, constant: 0).isActive = true
                let detailLabel = UILabel()
                detailLabel.font = UIFont.vodafoneRegular(16)
                bundleView.addSubview(detailLabel)
                detailLabel.text = amount.localValue
                detailLabel.translatesAutoresizingMaskIntoConstraints = false
                detailLabel.bottomAnchor.constraint(equalTo: bundleView.bottomAnchor, constant: 0).isActive = true
                detailLabel.topAnchor.constraint(equalTo: bundleView.topAnchor, constant: 0).isActive = true
                detailLabel.trailingAnchor.constraint(equalTo: bundleView.trailingAnchor,
                                                      constant: 0).isActive = true
            }
        } else {
            extraChargesView.isHidden = true
        }
    }

    func loadIncludedServices() {
        if stackViewServices.arrangedSubviews.isEmpty {
            let imageViewMobile = UIImageView(image: UIImage(named: "icMobile",
                                                             in: Bundle.mva10Billing,
                                                             compatibleWith: nil))
            let imageViewRouter = UIImageView(image: UIImage(named: "icRouter",
                                                             in: Bundle.mva10Billing,
                                                             compatibleWith: nil))
            let imageViewParentalControl = UIImageView(image: UIImage(named: "icParentalControl",
                                                                      in: Bundle.mva10Billing,
                                                                      compatibleWith: nil))
            let imageViewTv = UIImageView(image: UIImage(named: "icTv", in: Bundle.mva10Billing, compatibleWith: nil))
            stackViewServices.addArrangedSubview(imageViewMobile)
            stackViewServices.addArrangedSubview(imageViewRouter)
            stackViewServices.addArrangedSubview(imageViewParentalControl)
            stackViewServices.addArrangedSubview(imageViewTv)
        }
    }
}
