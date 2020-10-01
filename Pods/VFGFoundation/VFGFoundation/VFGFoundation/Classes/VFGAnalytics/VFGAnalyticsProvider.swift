//
//  VFGAnalyticsProvider.swift
//  VFGFoundation
//
//  Created by Mohamed ELMeseery on 6/19/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

/**

 `AnalyticsProvider` is abstract analytics provider that can be e.g.(Tealium, GoogleAnalytics, Smapi, Drift...).
 
 */

public protocol VFGAnalyticsProvider {
    var identifier: String { get set }
    func track(event: String, parameters: [String: Any]?)
}
