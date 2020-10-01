//
//  VFCVMOverlayViewModel.swift
//  VFGFoundation
//
//  Created by Ahmed Sultan on 8/27/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public enum VFGCVMOverlayStyle {
    case birthday
}

public struct VFGCVMOverlayViewModel {
    var title: String
    var content: String
    var confirmTitle: String
    var mainIcon: UIImage
    var backgroundImage: UIImage?
    var style: VFGCVMOverlayStyle = .birthday
    public init(title: String,
                content: String,
                confirmTitle: String,
                mainIcon: UIImage,
                backgroundImage: UIImage? = nil,
                style: VFGCVMOverlayStyle = .birthday) {
        self.title = title
        self.content = content
        self.confirmTitle = confirmTitle
        self.mainIcon = mainIcon
        self.backgroundImage = backgroundImage
        self.style = style
    }
}
