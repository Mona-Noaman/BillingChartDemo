//
//  ShowMoreCell.swift
//  VFGMVA10Billing
//
//  Created by Moustafa Hegazy on 5/5/20.
//

import UIKit

class ShowMoreCell: UICollectionViewCell {

    @IBOutlet var showMoreButton: UIButton!

    var showMoreAction = {}
    let defaultBillCount = 12

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureUI(title: String, recentBillCount: Int, monthsCounter: Int) {
        let remainCount = recentBillCount - monthsCounter
        if remainCount >= defaultBillCount {
            let buttonTitle = String(format: title, "\(defaultBillCount)")
            showMoreButton.setTitle(buttonTitle, for: .normal)
        } else {
            let buttonTitle = String(format: title, "\(remainCount)")
            showMoreButton.setTitle(buttonTitle, for: .normal)
        }
    }

    @IBAction func showMorePressed(_ sender: Any) {
        showMoreAction()
    }
}
