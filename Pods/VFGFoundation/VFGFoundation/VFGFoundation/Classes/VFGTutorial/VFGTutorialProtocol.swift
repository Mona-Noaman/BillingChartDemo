//
//  VFGTutorialProtocol.swift
//  VFGLogin
//
//  Created by Mohamed Mahmoud Zaki on 2/26/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public protocol VFGTutorialManagerProtocol: class {
    func firstActionTapped()
    func secondActionTapped()
}

public protocol VFGTutorialProtocol {
    var item: [VFGTutorialItemProtocol]? {get}
    var animationFileBundle: Bundle? {get}
    var firstButtonTitle: String? {get}
    var secondButtonTitle: String? {get}
}

public protocol VFGTutorialItemProtocol {
    var title: String? {get}
    var description: String? {get}
    var fileName: String? {get}
    var startingFrame: CGFloat? {get}
    var endingFrame: CGFloat? {get}
}
