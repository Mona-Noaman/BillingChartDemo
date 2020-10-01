//
//  VFGPageBanner.swift
//  VFGFoundation
//
//  Created by Hamsa Hassan on 8/31/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public class VFGPageBanner: UIView {

    @IBOutlet public weak var headerLabel: UILabel!
    @IBOutlet public weak var descriptionLabel: UILabel!
    @IBOutlet weak var primaryButton: VFGButton!
    @IBOutlet weak var secondaryButton: VFGButton!
    @IBOutlet weak var backgroundImage: UIImageView!
    public weak var delegate: VFGPageBannerProtocol?
    public weak var myPlanDelegate: VFGPageBannerDismissProtocol?

    @IBAction func closeBanner(_ sender: UIButton) {
        myPlanDelegate?.dismissBanner()
    }

    @IBAction func primaryButtonAction(_ sender: VFGButton) {
        delegate?.primaryButtonAction()
    }

    @IBAction func secondaryButtonAction(_ sender: VFGButton) {
        delegate?.secondaryButtonAction()
    }

    public func setupUI(model: VFGPageBannerModel) {
        headerLabel.text = model.header
        descriptionLabel.text = model.description
        primaryButton.setTitle(model.primaryButton, for: .normal)
        secondaryButton.setTitle(model.secondaryButton, for: .normal)
        backgroundImage.image = model.backgroundImage
    }

}
