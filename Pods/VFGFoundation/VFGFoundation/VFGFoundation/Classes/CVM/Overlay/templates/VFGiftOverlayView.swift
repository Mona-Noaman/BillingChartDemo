//
//  VFGiftOverlayView.swift
//  VFGFoundation
//
//  Created by Ahmed Sultan on 8/25/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

public class VFGGiftOverlayView: UIView {

    @IBOutlet var gradientView: UIView!
    @IBOutlet var mainIcon: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    @IBOutlet weak var giftUnwrapButton: UIButton!
    var giftUnwrapActionClosure: (() -> Void)?

    @IBAction func giftUnwrapPressed(_ sender: Any) {
        giftUnwrapActionClosure?()
    }
    public override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    func setupUI() {
        gradientView.setGradientBackgroundColor(colors: UIColor.giftOverlayGradient)
    }
    func setupStyle(with model: VFGCVMOverlayViewModel) {
        mainIcon?.image = model.mainIcon
        titleLabel?.text = model.title
        subtitleLabel?.text = model.content
        giftUnwrapButton.setTitle(model.confirmTitle, for: .normal)
    }
}
