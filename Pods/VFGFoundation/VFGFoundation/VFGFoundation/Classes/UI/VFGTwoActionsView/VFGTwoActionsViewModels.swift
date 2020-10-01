//
//  VFGTwoActionsViewModels.swift
//  VFGFoundation
//
//  Created by Mohamed Abd ElNasser on 7/1/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public struct VFGTitlesModel {
    public let title: String?
    public let description: String?
    public let descriptionAttributedString: NSMutableAttributedString?
    public let moreDetails: String?
    public let primaryButtonTitle: String
    public let secondaryButtonTitle: String

    public init(title: String?,
                description: String?,
                descriptionAttributedString: NSMutableAttributedString?,
                moreDetails: String?,
                primaryButtonTitle: String,
                secondaryButtonTitle: String) {
        self.title = title
        self.description = description
        self.descriptionAttributedString = descriptionAttributedString
        self.moreDetails = moreDetails
        self.primaryButtonTitle = primaryButtonTitle
        self.secondaryButtonTitle = secondaryButtonTitle
    }
}

public struct VFGTitlesFontModel {
    public let titleFont: UIFont
    public let descriptionFont: UIFont
    public let moreDetailsFont: UIFont

    public init(titleFont: UIFont = .vodafoneRegular(16),
                descriptionFont: UIFont = .vodafoneRegular(16),
                moreDetailsFont: UIFont = .vodafoneRegular(16)) {
        self.titleFont = titleFont
        self.descriptionFont = descriptionFont
        self.moreDetailsFont = moreDetailsFont
    }
}

public struct VFGTitlesAlignmentModel {
    public let titleAlignment: NSTextAlignment
    public let descriptionAlignment: NSTextAlignment
    public let moreDetailsAlignment: NSTextAlignment

    public init(titleAlignment: NSTextAlignment = .left,
                descriptionAlignment: NSTextAlignment = .left,
                moreDetailsAlignment: NSTextAlignment = .left) {
        self.titleAlignment = titleAlignment
        self.descriptionAlignment = descriptionAlignment
        self.moreDetailsAlignment = moreDetailsAlignment
    }
}
