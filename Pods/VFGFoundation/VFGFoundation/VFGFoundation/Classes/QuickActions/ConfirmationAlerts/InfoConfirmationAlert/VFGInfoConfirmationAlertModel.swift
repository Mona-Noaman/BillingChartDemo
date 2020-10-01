//
//  VFGInfoConfirmationAlertModel.swift
//  VFGFoundation
//
//  Created by Ahmed Sultan on 6/4/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public struct VFGInfoConfirmationAlertModel {
    public let infoIconName: String?
    public let infoQuestion: String
    public let infoAnswer: String?
    public let confimButtonTitle: String

    public init(infoIconName: String,
                infoQuestion: String,
                infoAnswer: String? = nil,
                confimButtonTitle: String) {
        self.infoIconName = infoIconName
        self.infoQuestion = infoQuestion
        self.infoAnswer = infoAnswer
        self.confimButtonTitle = confimButtonTitle
    }
}
