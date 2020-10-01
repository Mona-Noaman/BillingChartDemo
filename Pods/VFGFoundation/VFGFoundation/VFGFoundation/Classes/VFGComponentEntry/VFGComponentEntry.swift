//
//  VFGComponentEntry.swift
//  mva10
//
//  Created by Sandra Morcos on 12/13/18.
//  Copyright © 2019 vodafone. All rights reserved.
//

import Foundation
import UIKit

public protocol VFGComponentEntry: class {

    init(config: [String: Any]?, error: [String: Any]?)

    // View displayed on the app dashboard as a tile
    var cardView: UIView? { get }

    // ViewController which displayed after the selection of the tile from the dashboard
    var cardEntryViewController: UIViewController? { get }

    // Method executed when card is clicked if cardEntryViewController is nil
    func didSelectCard()

    // Methods to handle display state in dashboard collection views
    func willDisplay()

    func didEndDisplay()

    //notify cell whan it's visible with current offset
    func didScroll(percentage: CGFloat)
}

//Optional Methds
public extension VFGComponentEntry {
    func didSelectCard() {}
    func willDisplay() {}
    func didEndDisplay() {}
    func didScroll(percentage: CGFloat) {}
}
