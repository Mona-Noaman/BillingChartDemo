//
//  Encodable+ToString.swift
//  VFGFoundation
//
//  Created by Tomasz Czyżak on 19/06/2019.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

public extension Encodable {

    func toString() -> String? {
        guard let jsonData = try? JSONEncoder().encode(self) else {
            return nil
        }
        return String(data: jsonData, encoding: .utf8)
    }

}
