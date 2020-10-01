//
//  PropertyStoring.swift
//  VFGMVA10Group
//
//  Created by Sandra Morcos on 6/17/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

public protocol PropertyStoring {
    associatedtype ObjectType
    func getAssociatedObject(_ key: UnsafeRawPointer!) -> ObjectType?
    func setAssociatedObject(_ key: UnsafeRawPointer!, newValue: ObjectType?)
}

extension PropertyStoring {
    public func getAssociatedObject(_ key: UnsafeRawPointer!) -> ObjectType? {
        guard let value = objc_getAssociatedObject(self, key) as? ObjectType else {
            return nil
        }
        return value
    }

    public func setAssociatedObject(_ key: UnsafeRawPointer!, newValue: ObjectType?) {
        objc_setAssociatedObject(self, key, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
}
