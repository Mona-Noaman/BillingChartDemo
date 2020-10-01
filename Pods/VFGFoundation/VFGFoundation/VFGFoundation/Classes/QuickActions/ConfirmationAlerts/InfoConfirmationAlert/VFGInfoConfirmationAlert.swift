//
//  VFGInfoConfirmationAlert.swift
//  VFGFoundation
//
//  Created by Ahmed Sultan on 6/4/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public protocol VFGInfoConfirmationAlertDelegate: class {
    func confirmActionPressed(completion: (() -> Void)?)
}

public class VFGInfoConfirmationAlert: UIView {

    // MARK: IBOutlets
    @IBOutlet weak var infoIconImageView: UIImageView!
    @IBOutlet weak var infoQuestionLabel: UILabel!
    @IBOutlet weak var infoAnswerLabel: UILabel!
    @IBOutlet weak var confirmButton: VFGButton!

    // MARK: Probs
    public weak var delegate: VFGInfoConfirmationAlertDelegate?
    public var model: VFGInfoConfirmationAlertModel! {
        didSet {
            setupUI()
        }
    }

    // MARK: private methods
    private func setupUI() {
        infoIconImageView.image = UIImage(named: model.infoIconName, in: Bundle.foundation)
        infoQuestionLabel.text = model.infoQuestion
        infoAnswerLabel.text = model.infoAnswer
        confirmButton.setTitle(model.confimButtonTitle, for: .normal)
    }

    @IBAction private func confirm(_ sender: Any) {
        delegate?.confirmActionPressed(completion: nil)
    }
}
