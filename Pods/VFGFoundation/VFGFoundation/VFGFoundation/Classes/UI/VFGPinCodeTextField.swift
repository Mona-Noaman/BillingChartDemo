//
//  PinCodeTextField.swift
//  PinCodeTextField
//
//  Created by Hussein Gamal on 09/07/19.
//  Copyright © 2019 organization. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable open class VFGPinCodeTextField: UIView {
    public weak var delegate: VFGPinCodeTextFieldDelegate?

    // MARK: Customizable from Interface Builder
    @IBInspectable public var borderViewWidth: CGFloat = 50
    @IBInspectable public var borderViewHight: CGFloat = 50
    @IBInspectable public var marginBetweenBorderViews: CGFloat = 10
    @IBInspectable public var characterLimit: Int = 4 {
        willSet {
            if characterLimit != newValue {
                updateView()
            }
        }
    }
    @IBInspectable public var placeholderText: String?
    @IBInspectable public var text: String? {
        didSet {
            updateView()
        }
    }

    @IBInspectable public var fontSize: CGFloat = 26 {
        didSet {
            font = UIFont.vodafoneLite(fontSize)
            updateView()
        }
    }
    @IBInspectable public var textColor: UIColor = .VFGDefaultInputText
    @IBInspectable public var placeholderColor: UIColor = .VFGDefaultInputPlaceholderText
    @IBInspectable public var isSecure: Bool = true
    @IBInspectable public var needToUpdateBorderView: Bool = true
    @IBInspectable public var characterBackgroundColor: UIColor = .clear
    @IBInspectable public var characterBackgroundCornerRadius: CGFloat = 6.0
    @IBInspectable public var highlightInputBorder: Bool = true

    // MARK: Customizable from code
    public var keyboardType: UIKeyboardType = UIKeyboardType.decimalPad
    public var keyboardAppearance: UIKeyboardAppearance = UIKeyboardAppearance.default
    public var autocorrectionType: UITextAutocorrectionType = UITextAutocorrectionType.no
    public var font: UIFont = UIFont.systemFont(ofSize: 14)
    public var allowedCharacterSet: CharacterSet = CharacterSet.alphanumerics
    public var textContentType: UITextContentType! = nil

    private var _inputView: UIView?
    open override var inputView: UIView? {
        get {
            return _inputView
        }
        set {
            _inputView = newValue
        }
    }

    // UIResponder
    private var _inputAccessoryView: UIView?
    @IBOutlet open override var inputAccessoryView: UIView? {
        get {
            return _inputAccessoryView
        }
        set {
            _inputAccessoryView = newValue
        }
    }

    public var isSecureTextEntry: Bool {
        get {
            return isSecure
        }
        @objc(setSecureTextEntry:) set {
            isSecure = newValue
        }
    }

    // MARK: Private
    internal var labels: [UILabel] = []
    internal var borderedViews: [UIView] = []
    internal var hasError = false {
        didSet {
            updateBorderdView()
        }
    }

    // MARK: Init and awake
    override public init(frame: CGRect) {
        super.init(frame: frame)
        postInitialize()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        postInitialize()
    }

    override open func awakeFromNib() {
        super.awakeFromNib()
        postInitialize()
    }

    override open func prepareForInterfaceBuilder() {
        postInitialize()
    }

    func postInitialize() {
        updateView()
    }

    // MARK: Overrides
    override open func layoutSubviews() {
        layoutCharactersAndPlaceholders()
        super.layoutSubviews()
    }

    override open var canBecomeFirstResponder: Bool {
        return true
    }

    @discardableResult override open func becomeFirstResponder() -> Bool {
        if hasError {
            text?.removeAll()
            hasError = false
        }
        delegate?.textFieldDidBeginEditing(self)
        return super.becomeFirstResponder()
    }

    @discardableResult override open func resignFirstResponder() -> Bool {
        delegate?.textFieldDidEndEditing(self)
        return super.resignFirstResponder()
    }

    // MARK: Private
    private func updateView() {
        if needToRecreateBorderViews() && delegate != nil {
            recreateBackgrounds()
        }
        if needToRecreateLabels() && delegate != nil {
            recreateLabels()
        }
        updateLabels()
        if needToUpdateBorderView {
            updateBorderdView()
        }
        setNeedsLayout()
    }

    internal func needToRecreateLabels() -> Bool {
        return characterLimit != labels.count
    }

    internal func needToRecreateBorderViews() -> Bool {
        return characterLimit != borderedViews.count
    }

    private func recreateLabels() {
        labels.forEach { $0.removeFromSuperview() }
        labels.removeAll()
        characterLimit.times { index in
            let label = createLabel()
            delegate?.accessibilityIdentifier(for: label, extraInfo: index)
            labels.append(label)
            addSubview(label)
        }
    }

    private func recreateBackgrounds() {
        borderedViews.forEach { $0.removeFromSuperview() }
        borderedViews.removeAll()
        characterLimit.times { index in
            let borderedView = createBorderedViews()
            delegate?.accessibilityIdentifier(for: borderedView, extraInfo: index)
            borderedViews.append(borderedView)
            addSubview(borderedView)
        }
    }

    private func updateLabels() {
        let textHelper = VFGTextHelper(text: text, placeholder: placeholderText, isSecure: isSecureTextEntry)
        for label in labels {
            let index = labels.firstIndex(of: label) ?? 0
            let currentCharacter = textHelper.character(atIndex: index)
            label.text = currentCharacter.map { String($0) }
            label.font = font
            let isPlaceholder = hasPlaceholder(index)
            label.textColor = labelColor(isPlaceholder: isPlaceholder)
        }
    }

    private func updateBorderdView() {
        if hasError {
            borderedViews.forEach { (backgroundView) in
                backgroundView.layer.borderColor = UIColor.VFGErrorInputOutline.cgColor
            }
            return
        }
        for borderdView in borderedViews {
            let index = borderedViews.firstIndex(of: borderdView) ?? 0
            if highlightInputBorder && isInput(index) {
                labels[index].text = "|"
                borderdView.layer.borderColor = UIColor.VFGSelectedInputOutline.cgColor
                borderdView.layer.borderWidth = 2.0
            } else {
                borderedViews[index].layer.borderColor = UIColor.VFGDefaultInputOutline.cgColor
                borderdView.layer.borderWidth = 1.0
            }
        }
    }

    private func labelColor(isPlaceholder placeholder: Bool) -> UIColor {
        return placeholder ? placeholderColor : textColor
    }

    private func hasPlaceholder(_ index: Int) -> Bool {
        let inputTextCount = text?.count ?? 0
        return index >= inputTextCount
    }

    private func isInput(_ index: Int) -> Bool {
        let inputTextCount = text?.count ?? 0
        return index == inputTextCount
    }

    private func createLabel() -> UILabel {
        let label = UILabel(frame: CGRect())
        label.font = font
        label.backgroundColor = UIColor.clear
        label.textAlignment = .center
        return label
    }

    private func createBorderedViews() -> UIView {
        let borderedView = UIView()
        borderedView.backgroundColor = characterBackgroundColor
        borderedView.layer.cornerRadius = characterBackgroundCornerRadius
        borderedView.layer.borderWidth = 1
        borderedView.layer.borderColor = UIColor.VFGDefaultInputOutline.cgColor
        borderedView.clipsToBounds = true
        return borderedView
    }
    public func setErrorState(hasError: Bool) {
        self.hasError = hasError
    }

    func layoutCharactersAndPlaceholders() {
        let marginsCount = characterLimit - 1
        let totalMarginsWidth = marginBetweenBorderViews * CGFloat(marginsCount)
        let totalBorderViewWidth = borderViewWidth * CGFloat(characterLimit)

        var currentBorderViewX: CGFloat = bounds.width / 2 - (totalBorderViewWidth + totalMarginsWidth) / 2
        var currentLabelCenterX = currentBorderViewX + borderViewWidth / 2

        for index in 0..<borderedViews.count {
            let background = borderedViews[index]
            background.frame = CGRect(x: currentBorderViewX, y: 0, width: borderViewWidth, height: borderViewHight )
            currentBorderViewX += borderViewWidth + marginBetweenBorderViews
        }

        labels.forEach {
            $0.sizeToFit()
            let labelWidth = $0.bounds.width
            let labelX = (currentLabelCenterX - labelWidth / 2).rounded(.down)
            $0.frame = CGRect(x: labelX, y: 0, width: labelWidth, height: borderViewHight)
            currentLabelCenterX += borderViewWidth + marginBetweenBorderViews
        }

    }

    // MARK: - Touches
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        let location = touch.location(in: self)
        if bounds.contains(location) {
            if delegate?.textFieldShouldBeginEditing(self) ?? true {
                _ = becomeFirstResponder()
            }
        }
    }

    // MARK: Text processing
    func canInsertCharacter(_ character: String) -> Bool {
        let newText = text.map { $0 + character } ?? character
        let isNewline = character.hasOnlyNewlineSymbols
        let isCharacterMatchingCharacterSet = character.trimmingCharacters(in: allowedCharacterSet).isEmpty
        let isLengthWithinLimit = newText.count <= characterLimit
        return !isNewline && isCharacterMatchingCharacterSet && isLengthWithinLimit
    }
}

// MARK: UIKeyInput
extension VFGPinCodeTextField: UIKeyInput {
    public var hasText: Bool {
        if let text = text {
            return !text.isEmpty
        } else {
            return false
        }
    }

    public func insertText(_ charToInsert: String) {
        if charToInsert.hasOnlyNewlineSymbols {
            if delegate?.textFieldShouldReturn(self) ?? true {
                 _ = resignFirstResponder()
            }
        } else if canInsertCharacter(charToInsert) {
            let newText = text.map { $0 + charToInsert } ?? charToInsert
            delegate?.textFieldValueChanged(self)
            text = newText
            if newText.count == characterLimit {
                if delegate?.textFieldShouldEndEditing(self) ?? true {
                    _ = resignFirstResponder()
                }
            }
        }
    }

    public func deleteBackward() {
        guard hasText else { return }
        text?.removeLast()
        delegate?.textFieldValueChanged(self)
    }
}
