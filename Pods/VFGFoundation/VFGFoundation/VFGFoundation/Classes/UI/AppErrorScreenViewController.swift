//
//  AppErrorScreenViewController.swift
//  VFGFoundation
//
//  Created by Hamsa Hassan on 3/15/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

public class AppErrorScreenViewController: UIViewController {

    @IBOutlet weak var errorTitle: UILabel!
    @IBOutlet weak var errorMessage: UILabel!
    @IBOutlet weak var buttonAction: VFGButton!
    @IBOutlet weak var errorImageView: UIImageView!

    public var appErrorButtonAction: (() -> Void)?

    public func configure(title: String,
                          message: String,
                          buttonText: String,
                          accessibilityIdInitial: String? = nil) {
        if !title.isEmpty,
            !description.isEmpty,
            !buttonText.isEmpty {
            errorTitle.text = title
            errorMessage.text = message
            buttonAction.titleLabel?.text = buttonText
        }

        setupAccessibilityIds(accessibilityIdInitial)
    }

    @IBAction func buttonActionPressed(_ sender: Any) {
        appErrorButtonAction?()
    }

    override public func viewDidLoad() {
        super.viewDidLoad()
    }

    public override func awakeFromNib() {
        _ = self.view
    }

    func setupAccessibilityIds(_ accessibilityIdInitial: String?) {
        guard let accessibilityIdInitial = accessibilityIdInitial else {
            return
        }

        errorTitle.accessibilityIdentifier = accessibilityIdInitial + "errorTitle"
        errorMessage.accessibilityIdentifier = accessibilityIdInitial + "errorDesc"
        errorImageView.accessibilityIdentifier = accessibilityIdInitial + "warningIcon"
        buttonAction.accessibilityIdentifier = accessibilityIdInitial + "actionButton"
    }
}
