//
//  VFGKeyChainService.swift
//  VFGDataAccess
//
//  Created by Esraa Eldaltony on 3/24/19.
//  Copyright © 2019 VFG. All rights reserved.
//

import Foundation
import Security

public class VFGKeyChainService: NSObject {
    // Constant Identifiers
    private static let userAccount = "AuthenticatedUser"
    private static let accessGroup = "SecuritySerivice"
    /**
     * Exposed methods to perform save and load queries.
     */
    public class func reset() {
        resetKeychain()
    }
    //saving
    public class func saveData(key: String, value: Data) {
        saveData(service: key, data: value)
    }
    //retreiving
    public class func data(forKey key: String) -> Data? {
        return loadData(key: key)
    }

    /**
     * Internal methods for querying the keychain.
     */
    private class func saveData(service: String, data: Data) {
        // Instantiate a new default keychain query
        let keychainQuery: NSMutableDictionary =
            NSMutableDictionary(objects: [kSecClassGenericPassword,
                                          service,
                                          userAccount,
                                          data],
                                forKeys: [kSecClass as NSString,
                                          kSecAttrService as NSString,
                                          kSecAttrAccount as NSString,
                                          kSecValueData as NSString])

        // Delete any existing items
        SecItemDelete(keychainQuery as CFDictionary)

        // Add the new keychain item
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }

    private class func loadData(key: String) -> Data? {
        return load(service: key)
    }

    private class func load<T>(service: String) -> T? {
        // Instantiate a new default keychain query
        // Tell the query to return a result
        // Limit our results to one item
        let keychainQuery: NSMutableDictionary =
            NSMutableDictionary(objects: [kSecClassGenericPassword,
                                          service,
                                          userAccount,
                                          kCFBooleanTrue,
                                          kSecMatchLimitOne],
                                forKeys: [kSecClass as NSString,
                                          kSecAttrService as NSString,
                                          kSecAttrAccount as NSString,
                                          kSecReturnData as NSString,
                                          kSecMatchLimit as NSString])

        var dataTypeRef: AnyObject?

        // Search for the keychain items
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: T?

        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? Data {
                contentsOfKeychain = retrievedData as? T
            }
        } else {
            VFGDebugLog("Nothing was retrieved from the keychain for key \(service). Status code \(status)")
        }
        return contentsOfKeychain
    }

    private class func resetKeychain() {
        let query = [
            (kSecClass as String): kSecClassGenericPassword
        ]
        if SecItemDelete(query as CFDictionary) != noErr {
            VFGDebugLog("Couldn't clear keychain.")
        }
    }
}
