//
//  StringExtension.swift
//  VFGMVA10
//
//  Created by Hussien Gamal Mohammed on 7/9/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

internal extension String {
    var hasOnlyNewlineSymbols: Bool {
        return trimmingCharacters(in: CharacterSet.newlines).isEmpty
    }

    var containsWhitespace: Bool {
        return rangeOfCharacter(from: .whitespacesAndNewlines) != nil
    }

    func tooShortText(_ length: Int) -> Bool {
        return count < length
    }
}

public extension String {
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }

        return String(data: data, encoding: .utf8)
    }

    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}
