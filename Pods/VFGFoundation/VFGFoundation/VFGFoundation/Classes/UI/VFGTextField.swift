//
//  VFGTextField.swift
//  VFGFoundation
//
//  Created by Esraa Eldaltony on 7/10/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

public class VFGTextField: UIView, UITextFieldDelegate {

    var textFieldView: VFGGenericTextField?
    public weak var delegate: VFGTextFieldProtocol?

    let countryCodeLabelWidthDefault: CGFloat = 50
    var textFieldLeadingDefault: CGFloat = 14
    internal var textFieldHintText: String? = ""
    internal var textFieldTipText: String?
    internal var hasError: Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }

    @objc public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customUI()
    }

    func customUI() {
        textFieldView = VFGGenericTextField.loadXib(bundle: Bundle.foundation)
        textFieldView?.frame = bounds
        textFieldView?.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        textFieldView?.textField.delegate = self
        textFieldView?.genericTextFieldDelegate = self
        guard let textFieldView = textFieldView else {
            return
        }
        addSubview(textFieldView)
    }
    public func setTextFieldIdentifier(with identifier: String?) {
        textFieldView?.setTextFieldIdentifier(with: identifier)
    }
    public func setErrorHintLabelIdentifier(with identifier: String?) {
        textFieldView?.setErrorHintLabelIdentifier(with: identifier)
    }
    public func setRightButtonIdentifier(with identifier: String?) {
        textFieldView?.setRightButtonIdentifier(with: identifier)
    }
    public var textFieldText: String {
        get {
            return textFieldView?.textField.text ?? ""
        }
        set {
            textFieldView?.textField.text = newValue
        }
    }

    public var textFieldErrorText: String? {
        get {
            return textFieldView?.errorHintLabel.text
        }
        set {
            textFieldView?.errorHintLabel.text = newValue
        }
    }

    public var textFieldPlaceHolderText: String? {
        get {
            return textFieldHintText
        }
        set {
            textFieldView?.textField.attributedPlaceholder = NSAttributedString(string: newValue ?? "",
                                                                                attributes:
                [NSAttributedString.Key.foregroundColor: UIColor.VFGDefaultInputPlaceholderText])
            textFieldHintText = newValue
        }
    }

    public var textFieldTopTitleText: String? {
        get {
            return textFieldView?.topLabel.text
        }
        set {
            textFieldView?.topLabel.text = newValue
        }
    }

    public var textFieldKeyboardType: UIKeyboardType {
        get {
            return textFieldView?.textField.keyboardType ?? UIKeyboardType.default
        }
        set {
            textFieldView?.textField.keyboardType = newValue
        }
    }

    public var textFieldRightIcon: UIImage? {
        get {
            return textFieldView?.rightButton.image(for: .normal)
        }
        set {
            textFieldView?.rightButton.setImage(newValue, for: .normal)
        }
    }

    public var textFieldTextColor: UIColor? {
        get {
            return textFieldView?.textField.textColor
        }
        set {
            textFieldView?.textField.textColor = newValue
        }
    }

    public var textFieldTextFont: UIFont? {
        get {
            return textFieldView?.textField.font
        }
        set {
            textFieldView?.textField.font = newValue
        }
    }

    public var isSecureTextEntry: Bool {
        get {
            return textFieldView?.textField.isSecureTextEntry ?? false
        }
        set {
            textFieldView?.textField.isSecureTextEntry = newValue
        }
    }

    public var textFieldTipTextEnabled: Bool {
        get {
            return !(textFieldView?.errorHintLabel.isHidden ?? false) && textFieldTipText != ""
        }
        set {
            textFieldView?.errorHintLabel.isHidden = !newValue
        }
    }

    public var allowedCharacters: String?
    public var notAllowedCharacters: String?
    public var maxLength: Int?

    public func configureTextField(topTitleText: String? = nil, placeHolder: String? = nil,
                                   inputType: UIKeyboardType? = nil,
                                   rightIcon: UIImage? = nil, secureTextEntry: Bool? = false,
                                   hasCountryCode: Bool? = false, countryCode: String? = nil, tipText: String? = nil) {
        let phoneCountryCode = "(+356)"

        if topTitleText != nil {
            textFieldTopTitleText = topTitleText ?? ""
        }
        if placeHolder != nil {
            textFieldPlaceHolderText = placeHolder ?? ""
        }
        if inputType != nil {
            textFieldKeyboardType = inputType ?? .default
        }
        textFieldView?.rightButton.isUserInteractionEnabled = (rightIcon != nil)
        textFieldRightIcon = rightIcon

        if secureTextEntry != nil {
            textFieldView?.textField.isSecureTextEntry = secureTextEntry ?? false
        }
        if hasCountryCode == true {
            configureCountryCode(countryCode ?? phoneCountryCode)
        }
        if tipText != nil {
            textFieldTipText = tipText
            textFieldView?.errorHintLabel.text = tipText
            textFieldView?.errorHintLabel.textColor = .VFGDefaultInputHelperText
            textFieldErrorText = tipText
            textFieldTipTextEnabled = true
        } else {
            textFieldTipText = ""
            textFieldErrorText = ""
            textFieldTipTextEnabled = false
        }
    }

    public func configureTextFieldStyle(textColor: UIColor? = .VFGDefaultInputText,
                                        textFont: UIFont? = .vodafoneRegular(18)) {
        textFieldTextColor = textColor
        textFieldTextFont = textFont
    }

	func setupUI() {
        frame = bounds
        autoresizingMask = [.flexibleHeight, .flexibleWidth]

        textFieldView?.errorHintLabel.textColor = .VFGDefaultInputHelperText
        textFieldView?.textField.tintColor = .VFGInputFieldCursor
        textFieldView?.textField.delegate = self

        textFieldView?.textFieldLeadingConstraints.constant = textFieldLeadingDefault

        textFieldView?.countryCodeLabelWidthConstraint.constant = 0
    }

    public class func loadXib() -> VFGTextField? {
        return Bundle.foundation.loadNibNamed("VFGTextField", owner: self, options: nil)?.first as? VFGTextField
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    public func configureCountryCode(_ countryCode: String) {
        textFieldView?.countryCodeLabel.text = countryCode
        textFieldKeyboardType = .phonePad
        textFieldView?.countryCodeLabelWidthConstraint.constant = countryCodeLabelWidthDefault
        let textFieldCountryCodeWidthConstraint = textFieldView?.countryCodeLabelWidthConstraint.constant ?? 0
        textFieldView?.textFieldLeadingConstraints.constant = textFieldLeadingDefault +
            textFieldCountryCodeWidthConstraint + 6
    }

    public func showError(title: String? = nil,
                          font: UIFont? = .vodafoneRegular(15),
                          textColor: UIColor? = .VFGErrorInputHelperText,
                          image: UIImage? = nil) {

        textFieldView?.changeBorderState(to: .error)
        hasError = true
        if image != nil {
            textFieldView?.rightButton.setImage(image, for: .normal)
        }
        if let title = title {
            textFieldView?.errorHintLabel.isHidden = false
            textFieldView?.errorHintLabel.text = title
            textFieldView?.errorHintLabel.font = font
            textFieldView?.errorHintLabel.textColor = textColor
        } else {
            textFieldView?.errorHintLabel.isHidden = true
        }
    }

    public func hideError() {
        if textFieldTipTextEnabled {
            textFieldView?.errorHintLabel.text = textFieldTipText
            textFieldView?.errorHintLabel.textColor = .VFGDefaultInputHelperText
        } else {
            textFieldView?.errorHintLabel.text = ""
        }
        hasError = false
    }

    public func backToFullState(image: UIImage? = nil) {
        textFieldView?.changeBorderState(to: .full)
        if image != nil {
            textFieldView?.rightButton.setImage(image, for: .normal)
        }
    }

    public func getFocuesd() {
        textFieldView?.changeBorderState(to: .focus)
    }

    public func hideRightIcon() {
        textFieldView?.rightButton.isHidden = true
        textFieldView?.rightButton.isUserInteractionEnabled = false
    }

    public func showRightIcon() {
        textFieldView?.rightButton.isHidden = false
        textFieldView?.rightButton.isUserInteractionEnabled = true
    }
}
