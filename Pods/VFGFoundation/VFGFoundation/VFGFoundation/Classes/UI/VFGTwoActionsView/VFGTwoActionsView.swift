//
//  VFGTwoActionsView.swift
//  VFGFoundation
//
//  Created by Mohamed Abd ElNasser on 7/1/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

public class VFGTwoActionsView: UIView {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var iconStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleStackView: UIStackView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var descriptionStackView: UIStackView!
    @IBOutlet weak var moreDetailsLabel: UILabel!
    @IBOutlet weak var moreDetailsStackView: UIStackView!
    @IBOutlet weak var primaryButton: VFGButton!
    @IBOutlet weak var secondaryButton: VFGButton!

    public weak var delegate: VFGTwoActionsViewProtocol?
    var viewStyle: VFGTwoActionsViewStyle = .white {
        didSet {
            updateStyle(style: viewStyle)
        }
    }

    override public func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }

    private func setupUI() {
        frame = bounds
        autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }

    public func configure(viewStyle: VFGTwoActionsViewStyle,
                          iconImage: UIImage?,
                          titlesModel: VFGTitlesModel,
                          titlesFontModel: VFGTitlesFontModel = VFGTitlesFontModel(),
                          titlesAlignmentModel: VFGTitlesAlignmentModel = VFGTitlesAlignmentModel()) {
        hideEmptyFields(iconImage: iconImage, titlesModel: titlesModel)
        iconImageView.image = iconImage
        setupLabelsAlignment(titlesAlignmentModel: titlesAlignmentModel)
        setupLabelsFont(titlesFontModel: titlesFontModel)
        setupLabelsText(titlesModel: titlesModel)
        self.viewStyle = viewStyle
    }

    func hideEmptyFields(iconImage: UIImage?, titlesModel: VFGTitlesModel) {
        iconStackView.arrangedSubviews.first?.isHidden = iconImage == nil
        titleStackView.arrangedSubviews.first?.isHidden = titlesModel.title == nil
        moreDetailsStackView.arrangedSubviews.first?.isHidden = titlesModel.moreDetails == nil
        if titlesModel.description == nil,
            titlesModel.descriptionAttributedString == nil {
            descriptionStackView.arrangedSubviews.first?.isHidden = true
        } else {
            descriptionStackView.arrangedSubviews.first?.isHidden = false
        }
    }

    func updateStyle(style: VFGTwoActionsViewStyle) {
        let isWhiteStyle = style == .white
        titleLabel.textColor = isWhiteStyle ? .VFGPrimaryText : .white
        descriptionLabel.textColor = isWhiteStyle ? .VFGPrimaryText : .white
        moreDetailsLabel.textColor = isWhiteStyle ? .VFGPrimaryText : .white
        primaryButton.buttonStyle = isWhiteStyle ? 0 : 2
        primaryButton.backgroundStyle = isWhiteStyle ? 0 : 1
        secondaryButton.buttonStyle = isWhiteStyle ? 1 : 4
        secondaryButton.backgroundStyle = isWhiteStyle ? 0 : 2
        secondaryButton.borderColor = isWhiteStyle ? .VFGSecondaryButtonOutline : .white

        if isWhiteStyle {
            containerView.backgroundColor = .VFGWhiteBackground
        } else {
            containerView.backgroundColor = .clear
            secondaryButton.backgroundColor = .clear
            secondaryButton.setTitleColor(.white, for: .normal)
        }
    }

    func setupLabelsText(titlesModel: VFGTitlesModel) {
        titleLabel.text = titlesModel.title
        if let descriptionText = titlesModel.description {
            descriptionLabel.text = descriptionText
        } else if let descriptionAttributedString = titlesModel.descriptionAttributedString {
            descriptionLabel.attributedText = descriptionAttributedString
        }
        moreDetailsLabel.text = titlesModel.moreDetails
        primaryButton.setTitle(titlesModel.primaryButtonTitle, for: .normal)
        secondaryButton.setTitle(titlesModel.secondaryButtonTitle, for: .normal)
    }

    func setupLabelsFont(titlesFontModel: VFGTitlesFontModel) {
        titleLabel.font = titlesFontModel.titleFont
        descriptionLabel.font = titlesFontModel.descriptionFont
        moreDetailsLabel.font = titlesFontModel.moreDetailsFont
    }

    func setupLabelsAlignment(titlesAlignmentModel: VFGTitlesAlignmentModel) {
        titleLabel.textAlignment = titlesAlignmentModel.titleAlignment
        descriptionLabel.textAlignment = titlesAlignmentModel.descriptionAlignment
        moreDetailsLabel.textAlignment = titlesAlignmentModel.moreDetailsAlignment
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                secondaryButton.borderColor = viewStyle == .white ? .VFGSecondaryButtonOutline : .white
            }
        }
    }

    // MARK: - Actions
    @IBAction func primaryButtonAction(_ sender: Any) {
        delegate?.primaryButtonAction()
    }

    @IBAction func secondaryButtonAction(_ sender: Any) {
        delegate?.secondaryButtonAction()
    }
}
