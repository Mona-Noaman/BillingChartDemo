//
//  VFGStepAction.swift
//  VFGFoundation
//
//  Created by Yahya Saddiq on 8/26/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//
@objc enum VFGStepAction: Int {
    case complete, skip, returnToPreviousStep
    case link // should marked as private
}
