//
//  VFGPageControl.swift
//  VFGFoundation
//
//  Created by Yahya Saddiq on 3/29/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

public class VFGPageControl: UIView {
    public var numberOfPages: Int = 0 {
        didSet {
            guard numberOfPages != oldValue else { return }
            numberOfPages = max(0, numberOfPages)
            invalidateIntrinsicContentSize()
            dotViews =
                (0..<numberOfPages).map { _ in VFGCircularView(frame: CGRect(origin: .zero,
                                                                             size: CGSize(side: dotSize))) }
        }
    }

    public var currentPage: Int = 0 {
        didSet {
            guard currentPage != oldValue else { return }
            currentPage = max(0, min(numberOfPages, currentPage))
            updateColors()
            if (0..<centerDots).contains(currentPage - pageOffset) {
                centerOffset = currentPage - pageOffset
            } else {
                pageOffset = currentPage - centerOffset
            }
        }
    }

    public var maxDots = 7 {
        didSet {
            maxDots = max(3, maxDots)
            if maxDots % 2 == 0 {
                maxDots += 1
                VFGErrorLog("maxPages has to be an odd number")
            }
            invalidateIntrinsicContentSize()
            updatePositions()
        }
    }

    public var centerDots = 3 {
        didSet {
            centerDots = max(1, centerDots)
            if centerDots % 2 == 0 {
                centerDots += 1
                VFGErrorLog("centerDots has to be an odd number")
            }
            updatePositions()
        }
    }

    var dotColor = UIColor.VFGPageControlTint {
        didSet {
            updateColors()
        }
    }

    var selectedColor = UIColor.VFGPageControlCurrentPage {
        didSet {
            updateColors()
        }
    }

    var dotSize: CGFloat = 7 {
        didSet {
            dotSize = max(1, dotSize)
            dotViews.forEach { $0.frame = CGRect(origin: .zero, size: CGSize(side: dotSize)) }
            updatePositions()
        }
    }

    var spacing: CGFloat = 4 {
        didSet {
            spacing = max(1, spacing)
            updatePositions()
        }
    }

    private var centerOffset = 0
    private var pageOffset = 0 {
        didSet {
            DispatchQueue.main.asyncAfter(deadline: .now()) {
                UIView.animate(withDuration: 0.1, animations: self.updatePositions)
            }
        }
    }

    private var dotViews: [UIView] = [] {
        didSet {
            oldValue.forEach { $0.removeFromSuperview() }
            dotViews.forEach(addSubview)
            updateColors()
            updatePositions()
        }
    }

    init() {
        super.init(frame: .zero)
        isOpaque = false
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        isOpaque = false
    }

    private var lastSize = CGSize.zero
    override public func layoutSubviews() {
        super.layoutSubviews()
        guard bounds.size != lastSize else { return }
        lastSize = bounds.size
        updatePositions()
    }

    private func updateColors() {
        dotViews.enumerated().forEach { page, dot in
            dot.backgroundColor = page == currentPage ? selectedColor : dotColor
        }
    }

    private func updatePositions() {
        let sidePages = (maxDots - centerDots) / 2
        let horizontalOffset = CGFloat(-pageOffset + sidePages) * (dotSize + spacing) +
            (bounds.width - intrinsicContentSize.width) / 2
        let centerPage = centerDots / 2 + pageOffset
        dotViews.enumerated().forEach { page, dot in
            let center = CGPoint(
                x: horizontalOffset + bounds.minX + dotSize / 2 + (dotSize + spacing) * CGFloat(page),
                y: bounds.midY)
            let scale: CGFloat = {
                let distance = abs(page - centerPage)
                if distance > (maxDots / 2) { return 0 }
                return [1, 0.70, 0.44, 0.33][clamp(value: distance - centerDots / 2, min: 0, max: 3)]
            }()
            dot.center = center
            dot.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
    }

    override public var intrinsicContentSize: CGSize {
        let pages = min(maxDots, self.numberOfPages)
        let width = CGFloat(pages) * dotSize + CGFloat(pages - 1) * spacing
        let height = dotSize
        return CGSize(width: width, height: height)
    }
}
