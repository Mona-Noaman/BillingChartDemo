//
//  VFGWebViewController.swift
//  VFGFoundation
//
//  Created by Mohamed Abd ElNasser on 9/3/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import UIKit
import WebKit

public struct VFGWebViewModel {
    var urlString: String
    public init(urlString: String) {
        self.urlString = urlString
    }
}

public protocol VFGWebViewDelegate: class {
    func close(sender viewController: VFGWebViewController)
}

public class VFGWebViewController: UIViewController {

    @IBOutlet weak var webViewContainer: UIView!
    @IBOutlet weak var pageHeaderLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var leadingConstraintRefreshButton: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIButton!

    lazy var webView = WKWebView()
    public weak var delegate: VFGWebViewDelegate?
    var viewModel: VFGWebViewModel?

    private var progressObservation: NSKeyValueObservation?
    private var titleObservation: NSKeyValueObservation?

    override public func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }

    fileprivate func observeTitleChanges() {
        titleObservation = webView.observe(\WKWebView.title, options: .new) { [weak self] (webView, _) in
            if let title = webView.title {
                self?.pageHeaderLabel.text = title
            }
        }
    }

    fileprivate func observeProgress() {
        progressObservation = webView.observe(\WKWebView.estimatedProgress, options: .new) {[weak self] (webView, _) in
            self?.updateProgressBar(value: Float(webView.estimatedProgress))
        }
    }

    func updateProgressBar(value: Float) {
        progressView.progress = value
        if value >= 1 {
            progressView.isHidden = true
        } else {
            progressView.isHidden = false
        }
    }

    func setupView() {
        progressView.progress = 0
        progressView.isHidden = false

        webView.frame = CGRect(x: 0,
                               y: 0,
                               width: UIScreen.main.bounds.width,
                               height: UIScreen.main.bounds.maxY - webViewContainer.frame.minY)

        guard let urlString = viewModel?.urlString,
            let url = URL(string: urlString) else {
                return
        }

        webView.navigationDelegate = self
        webView.load(URLRequest(url: url))
        webViewContainer.addSubview(webView)

        pageHeaderLabel.font = .vodafoneRegular(19)
        pageHeaderLabel.textColor = .VFGPrimaryText

        observeProgress()
        observeTitleChanges()
        backButtonSetup()
    }
    deinit {
        self.titleObservation = nil
        self.progressObservation = nil
    }

    // MARK: private methods
    private func backButtonSetup() {
        let isHidden = !webView.canGoBack
        let backHiddenConstant = CGFloat(17)
        let backAvailableConstant = CGFloat(57)
        backButton.isHidden = isHidden
        leadingConstraintRefreshButton.constant = isHidden ?  backHiddenConstant : backAvailableConstant
        view.layoutSubviews()
    }

    // MARK: Actions
    @IBAction func closeButton(_ sender: UIButton) {
        delegate?.close(sender: self)
    }

    @IBAction func refreshButton(_ sender: UIButton) {
        webView.reload()
    }

    @IBAction func backButton(_ sender: Any) {
        webView.goBack()
    }
}

extension VFGWebViewController: WKNavigationDelegate {

    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        backButtonSetup()
    }
}
