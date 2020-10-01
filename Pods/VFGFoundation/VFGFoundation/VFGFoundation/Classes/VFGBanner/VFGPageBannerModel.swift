//
//  VFGPageBannerModel.swift
//  VFGFoundation
//
//  Created by Hamsa Hassan on 9/1/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public struct VFGPageBannerModel {
    var header: String
    var description: String
    var primaryButton: String
    var secondaryButton: String
    var backgroundImage: UIImage?
    public init(header: String,
                description: String,
                primaryButton: String,
                secondaryButton: String,
                backgroundImage: UIImage? = UIImage(named: "bannerBG", in: Bundle.foundation)) {
        self.header = header
        self.description = description
        self.primaryButton = primaryButton
        self.secondaryButton = secondaryButton
        self.backgroundImage = backgroundImage
    }
}
