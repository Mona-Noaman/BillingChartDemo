//
//  VFGPageBannerProtocols.swift
//  VFGFoundation
//
//  Created by Hamsa Hassan on 9/1/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public protocol VFGPageBannerDismissProtocol: class {
    func dismissBanner()
}

public protocol VFGPageBannerProtocol: class {
    func primaryButtonAction()
    func secondaryButtonAction()
}
