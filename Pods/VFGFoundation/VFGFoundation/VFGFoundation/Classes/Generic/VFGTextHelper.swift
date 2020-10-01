//
//  VFGTextHelper.swift
//  VFGFoundation
//
//  Created by Hussien Gamal Mohammed on 7/9/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

class VFGTextHelper {
    let text: String?
    let placeholderText: String?
    let isSecureTextEntry: Bool

    init(text: String?, placeholder: String? = "", isSecure: Bool = false) {
        self.text = text
        self.placeholderText = placeholder
        self.isSecureTextEntry = isSecure
    }

    func character(atIndex index: Int) -> Character? {
        let inputTextCount = text?.count ?? 0
        let placeholderTextLength = placeholderText?.count ?? 0
        let character: Character?
        if index < inputTextCount {
            let string = text ?? ""
            character = isSecureTextEntry ? "•" : string[string.index(string.startIndex, offsetBy: index)]
        } else if index < placeholderTextLength {
            let string = placeholderText ?? ""
            character = string[string.index(string.startIndex, offsetBy: index)]
        } else {
            character = nil
        }
        return character
    }
}
