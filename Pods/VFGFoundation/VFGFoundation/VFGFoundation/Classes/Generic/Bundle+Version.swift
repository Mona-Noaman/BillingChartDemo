//
//  Bundle+Version.swift
//  VFGFoundation
//
//  Created by Esraa Eldaltony on 6/27/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

private struct Keys {
    static let shortVersion = "CFBundleShortVersionString"
    static let version = "CFBundleVersion"
    static let executable = "CFBundleExecutable"
}

private struct Const {
    static let unknown = "Unknown"
}

extension Bundle {
    public var appShortVersion: String {
        return object(forInfoDictionaryKey: Keys.shortVersion) as? String ?? Const.unknown
    }

    public var appVersion: String {
        return object(forInfoDictionaryKey: Keys.version) as? String ?? Const.unknown
    }

    public var applicationName: String {
        return object(forInfoDictionaryKey: Keys.executable) as? String ?? Const.unknown
    }
}
