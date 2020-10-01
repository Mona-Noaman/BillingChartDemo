//
//  VFGButton.swift
//  VFGFoundation
//
//  Created by Mohamed Abd ElNasser on 6/30/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

@IBDesignable
public class VFGButton: UIButton {

    public enum ButtonStyle: Int {
        case primary
        case secondary
        case secondaryOptionTwo
        case tertiary
        case customStyle
        case icon
    }
    var type: ButtonStyle = .customStyle

    public override var isHighlighted: Bool {
        didSet {
            editButtonStyle()
        }
    }
    @IBInspectable var titleColor: UIColor? {
        set {
            if let color = newValue {
                setTitleColor(color, for: .normal)
            } else {
                setTitleColor(.white, for: .normal)
            }
        }
        get {
            return self.titleColor(for: .normal)
        }
    }

    @IBInspectable public var buttonStyle: Int {
        get {
            return type.rawValue
        }
        set(buttonType) {
            type = ButtonStyle(rawValue: buttonType) ?? .customStyle
            editButtonStyle()
        }
    }

    public enum BackgroundStyle: Int {
        case light
        case dark
        case red
    }

    var backgroundType: BackgroundStyle = .light
    @IBInspectable public var backgroundStyle: Int {
        get {
            return backgroundType.rawValue
        }
        set (type) {
            backgroundType = BackgroundStyle(rawValue: type) ?? .light
            editButtonStyle()
        }
    }

    public var enabledColor: UIColor? {
        willSet {
            if isEnabled == true {
                backgroundColor = newValue
            }
        }
    }

    public var disabledColor: UIColor? {
        willSet {
            if isEnabled == false {
                backgroundColor = newValue
            }
        }
    }

    func editButtonStyle() {
        switch backgroundType {
        case .light:
            lightBackground()
        case .dark:
            darkBackground()
        case .red:
            redbackground()
        }
    }

    func lightBackground() {
        switch type {
        case .primary:
            backgroundColor = isHighlighted ? .VFGPrimaryButtonActive :
                isEnabled ? .VFGPrimaryButton : .VFGDisabledButton
            let textColor: UIColor =  isHighlighted ? .VFGPrimaryButtonActiveText :
                isEnabled ? .VFGPrimaryButtonText : .VFGDisabledButtonText
            setTitleColor(textColor, for: .normal)
        case .secondary:
            if isEnabled {
                layer.borderWidth = 1
                backgroundColor = .VFGSecondaryButton
                layer.borderColor = UIColor.VFGSecondaryButtonOutline.cgColor
                setTitleColor(.VFGSecondaryButtonText, for: .normal)
                if isHighlighted {
                    layer.borderColor = UIColor.VFGSecondaryButtonActiveOutline.cgColor
                    backgroundColor = .VFGSecondaryButtonActive
                }
            } else {
                layer.borderWidth = 0
                backgroundColor = .VFGDisabledButton
                setTitleColor(.VFGDisabledButtonText, for: .normal)
            }
        case .secondaryOptionTwo:
            break
        case .tertiary:
            let textColor: UIColor = isHighlighted ? .VFGTertiaryButtonActiveText :
                isEnabled ? .VFGTertiaryButtonText : .VFGDisabledButtonText
            setTitleColor(textColor, for: .normal)
            backgroundColor = isHighlighted ? .VFGTertiaryButtonActive :
                isEnabled ? .VFGTertiaryButton : .VFGDisabledButton
        case .icon:
            contentEdgeInsets = UIEdgeInsets.zero
        case .customStyle:
            break
        }
    }

    func darkBackground() {
        switch type {
        case .primary:
            backgroundColor = isHighlighted ? .VFGPrimaryButtonActiveDarkBG :
                isEnabled ? .VFGPrimaryButtonDarkBG : .VFGDisabledButtonDarkBG
            let textColor: UIColor = isHighlighted ? .VFGPrimaryButtonActiveTextDarkBG :
                isEnabled ? .VFGPrimaryButtonTextDarkBG : .VFGDisabledButtonTextDarkBG
            setTitleColor(textColor, for: .normal)
        case .secondary:
            if isEnabled {
                layer.borderWidth = 1
                backgroundColor = .VFGSecondaryButtonDarkBG
                layer.borderColor = UIColor.VFGSecondaryButtonOutlineDarkBG.cgColor
                setTitleColor(.VFGSecondaryButtonTextDarkBG, for: .normal)
                if isHighlighted {
                    backgroundColor = .VFGSecondaryButtonActiveDarkBG
                    layer.borderColor = UIColor.VFGSecondaryButtonActiveOutlineDarkBG.cgColor
                    setTitleColor(.VFGSecondaryButtonActiveTextDarkBG, for: .normal)
                }
            } else {
                layer.borderWidth = 0
                backgroundColor = .VFGDisabledButtonDarkBG
                setTitleColor(.VFGDisabledButtonTextDarkBG, for: .normal)

            }
        case .secondaryOptionTwo:
            let textColor: UIColor = isHighlighted ? .VFGSecondaryButtonActiveTextDarkBGTwo :
                isEnabled ? .VFGSecondaryButtonTextDarkBGTwo : .VFGDisabledButtonTextDarkBG
            setTitleColor(textColor, for: .normal)
            backgroundColor = isHighlighted ? .VFGSecondaryButtonActiveDarkBGTwo :
                isEnabled ? .VFGSecondaryButtonDarkBGTwo : .VFGDisabledButtonDarkBG
        case .tertiary:
            let textColor: UIColor = isHighlighted ? .VFGTertiaryButtonActiveTextDarkBG :
                isEnabled ? .VFGTertiaryButtonTextDarkBG : .VFGDisabledButtonTextDarkBG
            setTitleColor(textColor, for: .normal)
            backgroundColor = isHighlighted ? .VFGTertiaryButtonActiveDarkBG :
                isEnabled ? .VFGTertiaryButtonDarkBG : .VFGDisabledButtonDarkBG
        case .icon:
            contentEdgeInsets = UIEdgeInsets.zero
        case .customStyle:
            break
        }
    }

    func redbackground() {
        switch type {
        case .primary:
            backgroundColor = isHighlighted ? .VFGPrimaryButtonActiveRedBG :
                isEnabled ? .VFGPrimaryButtonRedBG : .VFGDisabledButtonRedBG
            let textColor: UIColor = isHighlighted ? .VFGPrimaryButtonActiveTextRedBG :
                isEnabled ? .VFGPrimaryButtonTextRedBG : .VFGDisabledButtonText
            setTitleColor(textColor, for: .normal)
        case .secondary:
            setTitleColor(.VFGSecondaryButtonTextRedBG, for: .normal)
            setTitleColor(.VFGSecondaryButtonActiveTextRedBG, for: .highlighted)
            if isEnabled {
                backgroundColor = .VFGSecondaryButtonRedBG
                if isHighlighted {
                    backgroundColor = .VFGSecondaryButtonActiveRedBG
                }
            } else {
                backgroundColor = .VFGDisabledButtonRedBG
                setTitleColor(.VFGDisabledButtonTextRedBG, for: .normal)
            }
        case .secondaryOptionTwo:
            break
        case .tertiary:
            break
        case .icon:
            contentEdgeInsets = UIEdgeInsets.zero
        case .customStyle:
            break
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        customUI()
    }

    @objc public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        customUI()
    }

    func customUI() {
        isEnabled = true
        layer.cornerRadius = 6
        contentEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        setTitleColor(titleColor, for: .normal)
    }

    public override var isEnabled: Bool {
        didSet {
            let color = isEnabled ? enabledColor : disabledColor
            guard let buttonColor = color else {
                editButtonStyle()
                return
            }
            layer.borderWidth = 0
            backgroundColor = buttonColor
        }
    }
}
