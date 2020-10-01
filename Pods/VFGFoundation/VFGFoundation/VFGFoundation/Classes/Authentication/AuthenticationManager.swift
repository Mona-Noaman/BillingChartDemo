//
//  OAuth2Authentication.swift
//  VFGDataAccess
//
//  Created by Shimaa Magdi on 7/25/17.
//  Copyright © 2017 VFG. All rights reserved.
//

import Foundation

typealias AuthenticationManagerCompletion = (_ token: Token?, _ error: Error?) -> Void
// this protocol is used internally with OAuth2Authentication class
protocol AuthenticationManagerProtocol {
    func getToken(closure: @escaping AuthenticationManagerCompletion)
    func refreshToken(closure: @escaping AuthenticationManagerCompletion)
}
