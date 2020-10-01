//
//  VFGGenericTextField.swift
//  VFGFoundation
//
//  Created by Esraa Eldaltony on 7/1/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

class VFGGenericTextField: UIView {

    @IBOutlet weak var borderView: UIView!

    //topView
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topLabel: UILabel!

    //textField
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var textFieldLeadingConstraints: NSLayoutConstraint!

    //error
    @IBOutlet weak var errorHintLabel: UILabel!

    //phone textfield with country code
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var countryCodeLabelWidthConstraint: NSLayoutConstraint!
    weak var genericTextFieldDelegate: VFGGenericTextFieldProtocol?

    private func setupUI() {
        frame = bounds
        autoresizingMask = [.flexibleHeight, .flexibleWidth]

        borderView.cornerRadius = 6.0
        borderView.layer.borderWidth = 1
        borderView.layer.borderColor = UIColor.VFGDefaultInputOutline.cgColor

        errorHintLabel.isHidden = true
        topView.isHidden = true
        countryCodeLabelWidthConstraint.constant = 0

        textField.addTarget(self,
                            action: #selector(textFieldDidChange), for: .editingChanged)
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    @IBAction func rightButtonClicked(_ sender: Any) {
        genericTextFieldDelegate?.vfgTextFieldRightButtonClicked(self)
    }

    @objc func textFieldDidChange(textField: VFGGenericTextField, text: String) {
        genericTextFieldDelegate?.vfgTextFieldTextChange(textField, text: text)
    }
    func setTextFieldIdentifier(with identifier: String?) {
        textField.accessibilityIdentifier = identifier ?? ""
    }
    func setErrorHintLabelIdentifier(with identifier: String?) {
        errorHintLabel.accessibilityIdentifier = identifier ?? ""
    }
    func setRightButtonIdentifier(with identifier: String?) {
        rightButton.accessibilityIdentifier = identifier ?? ""
    }
    func changeBorderState(to state: BorderState) {
        switch state {
        case .normal:
            borderView.layer.borderColor = UIColor.VFGDefaultInputOutline.cgColor
            topLabel.textColor = UIColor.VFGDefaultInputLabel
            topView.isHidden = true
        case .focus:
            borderView.layer.borderColor = UIColor.VFGSelectedInputOutline.cgColor
            topLabel.textColor = UIColor.VFGSelectedInputLabel
            topView.isHidden = false

        case .error:
            borderView.layer.borderColor = UIColor.VFGErrorInputOutline.cgColor
            topLabel.textColor = UIColor.VFGErrorInputLabel
            topView.isHidden = false

        case .full:
            borderView.layer.borderColor = UIColor.VFGDefaultInputOutline.cgColor
            topLabel.textColor = UIColor.VFGDefaultInputLabel
            topView.isHidden = false
        }
    }
}

enum BorderState: String {
    case normal
    case focus
    case error
    case full
}
