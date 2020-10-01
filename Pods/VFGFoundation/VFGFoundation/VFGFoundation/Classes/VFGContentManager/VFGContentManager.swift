//
//  VFGContentManager.swift
//  VFGMVA10Group
//
//  Created by Mohamed Mahmoud Zaki on 5/16/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

public class VFGContentManager {
    public static var shared = VFGContentManager()
    public var dictionary = [String: String]()

    public func value(for key: String, in bundle: Bundle? = nil) -> String {
        let notFoundValue = "\(key)"
        var result: String = notFoundValue

        // Retrieve string from CMS (HerokuApp.com)
        // https://vfg-stubs.herokuapp.com/mva10cms?locale=%@
        // market-specific
        result = dictionary[key] ?? notFoundValue

        // If not found in CMS, retrieve string from customLocalizable
        // market-specific
        if result == notFoundValue {
            result = Bundle.main.localizedString(forKey: key,
                                                 value: notFoundValue,
                                                 table: "CustomLocalizable")
        }

        // If not found in CustomLocalizable, retrieve string from localizable.strings (VFGMVA10.csv)
        // https://github.vodafone.com/..../String-Resources/VFGMVA10.csv
        // market-common
        if result == notFoundValue {
            result = Bundle.main.localizedString(forKey: key,
                                                 value: notFoundValue,
                                                 table: nil)
        }

        // If not found in localizable.strings, retrieve from localizable.strings(English)
        if result == notFoundValue,
           String(Locale.current.identifier.prefix(2)) != "en" {
            if let path = Bundle.main.path(forResource: "en", ofType: "lproj"),
                let languageBundle = Bundle(path: path) {
                    result = languageBundle.localizedString(forKey: key,
                                                            value: notFoundValue,
                                                            table: nil)
            }
        }

        // If not found in MVA10's localizable.strings(English),
        // retrieve string from component localization file
        if result == notFoundValue,
            let bundle = bundle {
            result = bundle.localizedString(forKey: key,
                                            value: notFoundValue,
                                            table: nil)
        }

        let stringPlaceholderPattern = "\\%(?:\\d+\\$s)"
        return result.replacingOccurrences(of: stringPlaceholderPattern,
                                           with: "%@",
                                           options: .regularExpression)
    }
}
