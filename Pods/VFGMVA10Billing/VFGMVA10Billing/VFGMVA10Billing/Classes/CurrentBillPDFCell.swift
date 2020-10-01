//
//  CurrentBillPDFCell.swift
//  VFGMVA10Billing
//
//  Created by Moustafa Hegazy on 5/19/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit
import VFGFoundation

protocol CurrentBillPDFDelegate: class {
    func detailButtonPressed()
    func pdfButtonPressed()
    func negativeInfoButtonPressed()
}

class CurrentBillPDFCell: UICollectionViewCell {
    weak var delegate: CurrentBillPDFDelegate?

    @IBOutlet weak var pdfTitle: UILabel!
    @IBOutlet weak var detailTitle: UILabel!
    @IBOutlet weak var pdfIconImageView: UIImageView!
    @IBOutlet weak var detailIconImageView: UIImageView!

    @IBOutlet weak var containerStackView: UIStackView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var stackViewExtraCharges: UIStackView!

    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var pdfView: UIView!
    @IBOutlet weak var seperatorViewOne: UIView!
    @IBOutlet weak var extraChargesLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        seperatorViewOne.backgroundColor = .VFGGreyDividerOne
        contentView.roundCorners()
        localizeLabels()
        configureShadow()
        addActionToViews()
    }

    func localizeLabels() {
           extraChargesLabel.text = "billing_current_bill_extra_charges".localized(bundle: Bundle.mva10Billing)
           pdfTitle.text = "billing_details_pdf_report".localized(bundle: Bundle.mva10Billing)
           detailTitle.text = "billing_details_more_info".localized(bundle: Bundle.mva10Billing)
       }

    func addActionToViews() {
        let detailViewAction = UITapGestureRecognizer(target: self, action: #selector(self.detailViewAction))
        let pdfAction = UITapGestureRecognizer(target: self, action: #selector(self.pdfAction))
        detailView.addGestureRecognizer(detailViewAction)
        pdfView.addGestureRecognizer(pdfAction)
    }

    @objc func detailViewAction(_ sender: UITapGestureRecognizer) {
          // do other task
        delegate?.detailButtonPressed()
    }

    @objc func pdfAction(_ sender: UITapGestureRecognizer) {
          // do other task
        delegate?.pdfButtonPressed()
    }
}

extension CurrentBillPDFCell {

    func configure(data: HistoryModelProtocol?) {
        guard let data = data else { return }
        yearLabel.text = data.billYear
        monthLabel.text = data.billMonth
        valueLabel.text = data.amountDue?.localValue
        loadExtraServices(outOfBundles: data.outOfBundleAmount)
    }

    func loadExtraServices(outOfBundles: [OutOfBundleAmount]) {
        if !outOfBundles.isEmpty {
            stackViewExtraCharges.removeAllArrangedSubviews()
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
        }
    }

}
