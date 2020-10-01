//
//  VFCVMOverlayViewController.swift
//  VFGFoundation
//
//  Created by Ahmed Sultan on 8/25/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import UIKit

public class VFGCVMOverlayViewController: UIViewController {
    public var contentView: UIView?
    public var dismissCompletion: (() -> Void)?
    public var confirmCompletion: (() -> Void)?
    var overlayViewModel: VFGCVMOverlayViewModel?

    public convenience init(with model: VFGCVMOverlayViewModel) {
        self.init(nibName: String(describing: VFGCVMOverlayViewController.self),
                  bundle: Bundle.foundation)
        overlayViewModel = model
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        embedContent()
    }

    private func embedContent() {
        guard let overlayModel = overlayViewModel else { return }
        contentView?.removeFromSuperview()
        switch overlayModel.style {
        case .birthday:
            let birthDayView = VFGGiftOverlayView
                .loadXib(bundle: Bundle.foundation,
                         nibName: String(describing: VFGGiftOverlayView.self)) as? VFGGiftOverlayView
            birthDayView?.setupStyle(with: overlayModel)
            birthDayView?.giftUnwrapActionClosure = confirmCompletion
            contentView = birthDayView
        }
        guard let contentView = contentView else { return }
        view.embed(view: contentView)
        view?.sendSubviewToBack(contentView)
    }

    @IBAction func dismissOverlayPressed(_ sender: Any) {
        dismissCompletion?()
    }
    public override var prefersStatusBarHidden: Bool {
        return true
    }
}
