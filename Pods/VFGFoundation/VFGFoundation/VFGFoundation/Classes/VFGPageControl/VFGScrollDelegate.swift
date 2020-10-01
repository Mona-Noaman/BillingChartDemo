//
//  VFGScrollDelegate.swift
//  VFGFoundation
//
//  Created by Yahya Saddiq on 3/29/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

public class VFGScrollDelegate: NSObject, UIScrollViewDelegate {
    public let pageControl: VFGPageControl

    public init(pageControl: VFGPageControl) {
        self.pageControl = pageControl
    }

    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(page)
    }
}
