//
//  PrevBillCollectionCell.swift
//  VFGMVA10Group
//
//  Created by Samet MACİT on 29.11.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit
import VFGFoundation

class PrevBillCollectionCell: UICollectionViewCell {

    @IBOutlet weak var imageViewBill: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var labelMonth: UILabel!
    @IBOutlet weak var labelBillValue: UILabel!
    @IBOutlet weak var labelYear: UILabel!
    @IBOutlet weak var labelBillingPeriod: UILabel!

    @IBOutlet weak var seperatorView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        labelBillingPeriod.textColor = .VFGSecondaryText
        labelMonth.textColor = .VFGPrimaryText
        labelYear.textColor = .VFGPrimaryText
        labelBillValue.textColor = .VFGPrimaryText
        seperatorView.backgroundColor = .VFGGreyDividerOne
        imageViewBill.tintColor = .VFGListStatusPositive
        contentView.roundCorners()
        configureShadow()
    }
}

extension PrevBillCollectionCell {

    func configure(data: HistoryModelProtocol?) {
        guard let data = data else { return }
        labelYear.text = data.billYear
        labelMonth.text = data.billMonth
        labelBillValue.text = data.amountDue?.localValue
        labelBillingPeriod.text = data.billDateInterval

        if stackView.arrangedSubviews.isEmpty {
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

            stackView.addArrangedSubview(imageViewMobile)
            stackView.addArrangedSubview(imageViewRouter)
            stackView.addArrangedSubview(imageViewParentalControl)
            stackView.addArrangedSubview(imageViewTv)

        }
    }
}
