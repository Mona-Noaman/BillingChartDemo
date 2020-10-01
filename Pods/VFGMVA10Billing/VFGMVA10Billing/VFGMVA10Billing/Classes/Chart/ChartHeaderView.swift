//
//  ChartHeaderView.swift
//  VFGMVA10Group
//
//  Created by Samet MACİT on 4.12.2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

public protocol ChartHeaderDelegate: class {
    func closeButtonPressed()
}

public class ChartHeaderView: UICollectionReusableView {
    weak var delegate: ChartHeaderDelegate?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!

    override public func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
    }

    @objc func closeButtonPressed(_ sender: UIButton) {
        delegate?.closeButtonPressed()
    }
}
