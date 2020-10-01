//
//  Sequence+Unique.swift
//  VFGFoundation
//
//  Created by Yahya Saddiq on 5/11/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

public extension Sequence where Iterator.Element: Hashable {
    func unique() -> [Iterator.Element] {
        var seen: Set<Iterator.Element> = []
        return filter { seen.insert($0).inserted }
    }
}
