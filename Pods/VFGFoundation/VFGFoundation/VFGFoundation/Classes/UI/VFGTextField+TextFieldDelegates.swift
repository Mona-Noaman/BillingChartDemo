//
//  VFGTextField+TextFieldDelegates.swift
//  VFGFoundation
//
//  Created by Mohamed Abd ElNasser on 8/24/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

extension VFGTextField: VFGGenericTextFieldProtocol {
    // MARK: - textFieldDelegate
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        var textFieldLeadingConstraint: CGFloat = textFieldLeadingDefault
        if textFieldView?.countryCodeLabelWidthConstraint.constant != 0 {
            textFieldLeadingConstraint =
                textFieldLeadingDefault + 6 + (textFieldView?.countryCodeLabelWidthConstraint.constant ?? 0)
        }
        textFieldView?.textFieldLeadingConstraints.constant = textFieldLeadingConstraint
        textFieldView?.textField.placeholder = ""

        textFieldView?.changeBorderState(to: .focus)

        delegate?.vfgTextFieldDidBeginEditing(self)
    }

    public func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.vfgTextFieldDidEndEditing(self)
        if textFieldText.isEmpty {
            resetTextField()
        } else if !hasError {
            textFieldView?.changeBorderState(to: .full)
        }
    }

    public func resetTextField() {
        textFieldText = ""
        var textFieldLeadingConstraint: CGFloat = 14
        if textFieldView?.countryCodeLabelWidthConstraint.constant != 0 {
            textFieldLeadingConstraint =
                textFieldLeadingDefault + 6 + (textFieldView?.countryCodeLabelWidthConstraint.constant ?? 0)
        }
        textFieldView?.textFieldLeadingConstraints.constant = textFieldLeadingConstraint
        textFieldView?.textField.placeholder = textFieldHintText
        textFieldView?.changeBorderState(to: .normal)
    }

    public func textField(_ textField: UITextField,
                          shouldChangeCharactersIn range: NSRange,
                          replacementString string: String) -> Bool {

        // Allowed Characters Validation
        if let allowedCharacters = allowedCharacters {
            let allowedCharacters = CharacterSet(charactersIn: allowedCharacters)
            let characterSet = CharacterSet(charactersIn: string)
            if !allowedCharacters.isSuperset(of: characterSet) {
                return false
            }
        }

        // Not Allowed Characters Validation
        if let notAllowedCharacters = notAllowedCharacters {
            let notAllowedCharacters = CharacterSet(charactersIn: notAllowedCharacters)
            let characterSet = CharacterSet(charactersIn: string)
            if notAllowedCharacters.isSuperset(of: characterSet),
                string != "" { // Allow backspace
                return false
            }
        }

        // Max Length Validation
        if let maxLength = maxLength {
            if !isValidLength(textField: textField, range: range, string: string, maxLength: maxLength) {
                return false
            }
        }
        return delegate?.vfgTextFieldShouldChange(
            self,
            shouldChangeCharactersIn: range,
            replacementString: string
            ) ?? true
    }

    func isValidLength(textField: UITextField,
                       range: NSRange,
                       string: String,
                       maxLength: Int) -> Bool {
        guard let textFieldText = textField.text,
            let rangeOfTextToReplace = Range(range, in: textFieldText) else {
                return false
        }
        let substringToReplace = textFieldText[rangeOfTextToReplace]
        let count = textFieldText.count - substringToReplace.count + string.count
        return count <= maxLength
    }

    func vfgTextFieldRightButtonClicked(_ textField: VFGGenericTextField) {
        delegate?.vfgTextFieldRightButtonClicked(self)
    }

    func vfgTextFieldTextChange(_ textField: VFGGenericTextField, text: String) {
        textFieldView?.changeBorderState(to: .focus)
        delegate?.vfgTextFieldDidChange(self, text: textFieldText)
    }
}
