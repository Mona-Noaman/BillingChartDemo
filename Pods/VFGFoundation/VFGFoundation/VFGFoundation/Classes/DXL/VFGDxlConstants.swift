//
//  DxlConstants.swift
//  VFGFoundation
//
//  Created by Esraa Eldaltony on 3/15/20.
//  Copyright © 2020 Vodafone. All rights reserved.
//

import Foundation

public class VFGDxlConstants {
    public static let shared = VFGDxlConstants()
    private init() {}

    //constants
    public var clientID = ""
    public var countryCode = ""
    public var grantType = "authorization_code"
    public var accept = "application/json"
    public var acceptLanguage = "GR"
    public var contentType = "application/json"
}
