//
//  VFQuickActionsViewController.swift
//  VFGMVA10Group
//
//  Created by Sandra Morcos on 7/25/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

public class VFQuickActionsViewController: UIViewController {

    @IBOutlet weak var quickActionsView: UIView!
    @IBOutlet weak var pillView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var originalProportionalHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var scrollViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollViewTrailingConstraint: NSLayoutConstraint!
    var proportionalHeight: NSLayoutConstraint?

    var model: VFQuickActionsModel?
    let maximumHeightRatio: CGFloat = 0.95
    var isPresented = false
    public var onDismissCompletionClosure: (() -> Void)?

    var contentView: UIView?
    var style: VFQuickActionsStyle {
        model?.quickActionsStyle ?? .red
    }

    var hasMaxWidth: Bool {
        model?.hasMaxWidth ?? false
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        model?.quickActionsProtocol(delegate: self)
    }

    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard !isPresented else { return }
        UIView.animate(withDuration: 0.1) {
            self.view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
            let transform = CGAffineTransform(translationX: 0, y: 0)
            self.pillView.transform = transform
            self.quickActionsView.transform = transform
            self.isPresented = true
        }
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard !isPresented else { return }
        view.backgroundColor = .clear
        let transform = CGAffineTransform(translationX: 0, y: quickActionsView.frame.height)
        pillView.transform = transform
        quickActionsView.transform = transform
    }

    override public func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        if #available(iOS 13.0, *) {
            if traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                if style == .red {
                    quickActionsView.layer.sublayers?.first?.removeFromSuperlayer()
                    quickActionsView.setGradientBackgroundColor(colors: UIColor.VFGRedGradientDynamic)
                }
            }
        }
    }

    private func setupUI() {
        titleLabel.text = model?.quickActionsTitle
        if style == .red {
            quickActionsView.setGradientBackgroundColor(colors: UIColor.VFGRedGradientDynamic)
            titleLabel.textColor = .white
            closeButton.tintColor = .white
        } else {
            quickActionsView.backgroundColor = .VFGWhiteBackground
            titleLabel.textColor = .VFGPrimaryText
            closeButton.tintColor = .VFGGreyTint
        }
        quickActionsView.roundUpperCorners(cornerRadius: 6)
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(viewControllerDragged(_:)))
        view.addGestureRecognizer(panGestureRecognizer)
        setupContentView()
    }

    private func setupContentView() {
        guard let contentView = model?.quickActionsContentView else {
            return
        }

        if hasMaxWidth {
            scrollViewLeadingConstraint.constant = 0
            scrollViewTrailingConstraint.constant = 0
        } else {
            scrollViewLeadingConstraint.constant = 16
            scrollViewTrailingConstraint.constant = 16
        }
        scrollView.embed(view: contentView)
        contentView.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        contentView.layoutIfNeeded()
        let actualHeight = (contentView.frame.height
            + self.quickActionsView.frame.height
            - self.scrollView.frame.height)
        var multiplier = actualHeight / self.view.frame.height

        if multiplier > self.maximumHeightRatio {
            multiplier = self.maximumHeightRatio
        }
        if self.originalProportionalHeightConstraint != nil {
            self.originalProportionalHeightConstraint.isActive = false
        }
        self.proportionalHeight = self.quickActionsView.heightAnchor.constraint(equalTo: self.view.heightAnchor,
                                                                                multiplier: multiplier,
                                                                                constant: 0)
        self.proportionalHeight?.isActive = true
        self.contentView = contentView
        UIView.animate(withDuration: 0.2) { [weak self] in
            guard let self = self else { return }
            self.view.layoutSubviews()
            if self.style == .red {
                self.quickActionsView.backgroundColor = .VFGRedGradientEnd
            } else {
                self.quickActionsView.backgroundColor = .VFGWhiteBackground
            }
            self.quickActionsView.layer.sublayers?.first?.frame = self.quickActionsView.bounds
            self.quickActionsView.layer.layoutSublayers()
        }
    }

    private func relaodView() {
        contentView?.removeFromSuperview()
        proportionalHeight?.isActive = false
        titleLabel.text = model?.quickActionsTitle
        setupContentView()
    }

    @objc func viewControllerDragged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        if translation.y > 0 {
            let transform = CGAffineTransform(translationX: 0, y: translation.y)
            pillView.transform = transform
            quickActionsView.transform = transform
        }
        if gesture.state == .ended {
            let translation = gesture.translation(in: view)
            if translation.y >= quickActionsView.frame.height/2 {
                animatedDismiss()
            } else {
                UIView.animate(withDuration: 0.1) {
                    let transform = CGAffineTransform(translationX: 0, y: 0)
                    self.pillView.transform = transform
                    self.quickActionsView.transform = transform
                }
            }
        }
    }

    @IBAction func dismissViewController(_ sender: UIButton) {
        model?.closeQuickAction()
    }

    func animatedDismiss() {
        UIView.animate(withDuration: 0.2, animations: {
            self.view.backgroundColor = .clear
            let transform = CGAffineTransform(translationX: 0, y: self.quickActionsView.frame.height)
            self.pillView.transform = transform
            self.quickActionsView.transform = transform
        }, completion: { [weak self] (_) in
            guard let self = self else { return }
            self.dismiss(animated: false) { [weak self] in
                self?.onDismissCompletionClosure?()
            }
        })
    }

    static func viewController(with model: VFQuickActionsModel) -> VFQuickActionsViewController {
        let storyboard = UIStoryboard(name: "quickActions", bundle: Bundle.foundation)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: "VFQuickActionsViewController")
            as? VFQuickActionsViewController else {
                return VFQuickActionsViewController()
        }
        viewController.model = model
        return viewController
    }

    public static func presentQuickActionsViewController(with model: VFQuickActionsModel) {
        guard let navigationController = UIApplication.topViewController() else {
            return
        }

        let viewController = VFQuickActionsViewController.viewController(with: model)
        navigationController.present(viewController,
                                     animated: false,
                                     completion: nil)
    }
}

extension VFQuickActionsViewController: VFQuickActionsProtocol {

    public func reloadQuickAction(model: VFQuickActionsModel?) {
        guard let newModel = model else {return}
        self.model = newModel
        relaodView()
    }

    public func closeQuickAction() {
        animatedDismiss()
    }
}
