//
//  MVA10NavigationController.swift
//  VFGFoundation
//
//  Created by Mohamed Abd ElNasser on 12/10/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit

public class MVA10NavigationController: UINavigationController {

    var navigationView: MVA10NavigationView?
    var titles: [UIViewController: String] = [:]
    var accessibilityIDs: [UIViewController: String] = [:]
    private var topVC: UIViewController {
        return topViewController ?? UIViewController()
    }
    public var isTranslucent: Bool = false {
        didSet {
             navigationView?.isTranslucent = isTranslucent
        }
    }
    public var hasDivider: Bool = false {
        didSet {
             navigationView?.hasDivider = hasDivider
        }
    }
    public override func viewDidLoad() {
        super.viewDidLoad()

        navigationView = MVA10NavigationView.loadXib(bundle: Bundle.foundation)
        guard let navigationView = navigationView else { return }
        let statusBarHeight = UIApplication.shared.statusBarFrame.height
        let extraSafeArea = 16.0 + navigationBar.frame.height
        additionalSafeAreaInsets.top += extraSafeArea
        navigationView.frame = CGRect(x: navigationBar.frame.origin.x,
                                      y: navigationBar.frame.origin.y,
                                      width: navigationBar.frame.width,
                                      height: statusBarHeight + extraSafeArea)
        view.addSubview(navigationView)
        navigationView.backButton.addTarget(self,
                                            action: #selector(backTapped),
                                            for: .touchUpInside)
        navigationView.closeButton.addTarget(self,
                                             action: #selector(closeTapped),
                                             for: .touchUpInside)

        navigationView.backButton.isHidden = viewControllers.count < 2
        let title = titles[topVC]
        let accessibilityID = accessibilityIDs[topVC]
        navigationView.setTitle(title: title ?? "",
                                accessibilityIdentifier: accessibilityID ?? "")
        setNavigationBarHidden(true, animated: false)
    }

    public func setTitle(title: String,
                         accessibilityID: String = "",
                         for viewController: UIViewController) {
        titles[viewController] = title
        accessibilityIDs[viewController] = accessibilityID
        navigationView?.setTitle(title: title,
                                 accessibilityIdentifier: accessibilityID)
    }
    public func setAccessibilityIDs(closeButtonID: String = "", backButtonID: String = "") {
        navigationView?.setAccessibilityIDs(closeButtonID: closeButtonID, backButtonID: backButtonID)
    }

    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        modalPresentationStyle = .fullScreen
        super.pushViewController(viewController, animated: animated)
        adjustBackButtonVisibility()
        let title = titles[topVC]
        let accessibilityID = accessibilityIDs[topVC]
        navigationView?.setTitle(title: title ?? "",
                                 accessibilityIdentifier: accessibilityID ?? "")
    }

    fileprivate func executePopAction(_ popedViewControllers: [UIViewController]) -> [UIViewController] {
        adjustBackButtonVisibility()
        let oldTitle = titles[topVC]
        let oldID = accessibilityIDs[topVC]
        popedViewControllers.forEach {
            titles.removeValue(forKey: $0)
            accessibilityIDs.removeValue(forKey: $0)
            navigationView?.setTitle(title: oldTitle ?? "",
                                     accessibilityIdentifier: oldID ?? "")
        }

        return popedViewControllers
    }

    public override func popViewController(animated: Bool) -> UIViewController? {
        guard let popedViewController = super.popViewController(animated: animated) else {
            return nil
        }
        return executePopAction([popedViewController]).first
    }

    public override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        guard let popedViewControllers = super.popToRootViewController(animated: animated) else {
            return nil
        }
        return executePopAction(popedViewControllers)
    }

    public override func popToViewController(_ viewController: UIViewController,
                                             animated: Bool) -> [UIViewController]? {
        guard let popedViewControllers = super.popToViewController(viewController,
                                                                   animated: animated) else {
            return nil
        }

        return executePopAction(popedViewControllers)
    }

    @objc func closeTapped() {
        guard let navigationController = navigationController else {
            dismiss(animated: true, completion: {
                self.titles = [:]
                self.accessibilityIDs = [:]
            })
            return
        }
        navigationController.dismiss(animated: true, completion: {
            self.titles = [:]
            self.accessibilityIDs = [:]
        })
    }

    @objc private func backTapped() {
        _ = popViewController(animated: true)
    }

    private func adjustBackButtonVisibility() {
        navigationView?.backButton.isHidden = viewControllers.count < 2
    }
}
