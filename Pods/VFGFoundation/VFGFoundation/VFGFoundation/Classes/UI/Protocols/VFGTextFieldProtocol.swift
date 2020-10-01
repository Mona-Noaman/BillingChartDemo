//
//  VFGTextFieldProtocol.swift
//  VFGFoundation
//
//  Created by Esraa Eldaltony on 7/2/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

public protocol VFGTextFieldProtocol: class {
    func vfgTextFieldDidBeginEditing(_ vfgTextField: VFGTextField)
    func vfgTextFieldDidEndEditing(_ vfgTextField: VFGTextField)
    func vfgTextFieldDidChange(_ vfgTextField: VFGTextField, text: String)
    func vfgTextFieldRightButtonClicked(_ vfgTextField: VFGTextField)
    func vfgTextFieldShouldChange(
        _ vfgTextField: VFGTextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool
}
public extension VFGTextFieldProtocol {
    func vfgTextFieldDidChange(_ vfgTextField: VFGTextField, text: String) {}
    func vfgTextFieldShouldChange(
        _ vfgTextField: VFGTextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        return true
    }
}
