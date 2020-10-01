//
//  VFGGenericTextFieldProtocol.swift
//  VFGFoundation
//
//  Created by Hussien Gamal Mohammed on 8/7/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation
internal protocol VFGGenericTextFieldProtocol: class {
    func vfgTextFieldRightButtonClicked(_ textField: VFGGenericTextField)
    func vfgTextFieldTextChange(_ textField: VFGGenericTextField, text: String)
}
