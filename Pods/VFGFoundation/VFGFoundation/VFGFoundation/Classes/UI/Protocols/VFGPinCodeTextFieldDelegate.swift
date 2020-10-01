//
//  VFGPinCodeTextFieldDelegate.swift
//  VFGFoundation
//
//  Created by Hussien Gamal Mohammed on 7/9/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//
import Foundation

public protocol VFGPinCodeTextFieldDelegate: class {
    func textFieldShouldBeginEditing(_ textField: VFGPinCodeTextField) -> Bool
    // return false to disallow editing.

    func textFieldDidBeginEditing(_ textField: VFGPinCodeTextField) // became first responder

    func textFieldValueChanged(_ textField: VFGPinCodeTextField) // text value changed

    func textFieldShouldEndEditing(_ textField: VFGPinCodeTextField) -> Bool
    /*
     return true to allow editing to stop and to resign first responder status at the last character entered event.
     NO to disallow the editing session to end
    */

    func textFieldDidEndEditing(_ textField: VFGPinCodeTextField)
    // called when pinCodeTextField did end editing

    func textFieldShouldReturn(_ textField: VFGPinCodeTextField) -> Bool
    // called when 'return' key pressed. return false to ignore.

    func accessibilityIdentifier<T, U>(for element: T, extraInfo: U?)
}

public extension VFGPinCodeTextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: VFGPinCodeTextField) -> Bool { true }

    func textFieldDidBeginEditing(_ textField: VFGPinCodeTextField) { }

    func textFieldValueChanged(_ textField: VFGPinCodeTextField) { }

    func textFieldShouldEndEditing(_ textField: VFGPinCodeTextField) -> Bool { true }

    func textFieldDidEndEditing(_ textField: VFGPinCodeTextField) { }

    func textFieldShouldReturn(_ textField: VFGPinCodeTextField) -> Bool { true }

    func accessibilityIdentifier<T, U>(for element: T, extraInfo: U? = nil) { }
}
