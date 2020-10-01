//
//  Authentication.swift
//  VFGDataAccess
//
//  Created by Mohamed Magdy on 7/25/17.
//  Copyright © 2017 VFG. All rights reserved.
//

import Foundation

public struct Authentication: Codable {

    // MARK: - Properties
    private(set) var authenticationBaseUrl: String?
    private(set) var authenticationPathUrl: String?
    private(set) var clientID: String?
    private(set) var scope: String?
    private(set) var username: String?
    private(set) var password: String?
    private(set) var countryCode: String?
    private(set) var vfTargetStub: String?
    private(set) var grantType: String?
    private(set) var contentType: String?

    // for login authentication
    private(set) var accept: String?
    private(set) var acceptLanguage: String?
    private(set) var vFEXTBPID: String?
    private(set) var code: String?

    // MARK: - Init

    public init(authenticationBaseUrl: String?,
                authenticationPathUrl: String?,
                clientID: String?,
                scope: String?,
                username: String?,
                password: String?,
                countryCode: String?,
                vfTargetStub: String?,
                grantType: String?,
                contentType: String?) {

        self.authenticationBaseUrl = authenticationBaseUrl
        self.authenticationPathUrl = authenticationPathUrl
        self.clientID          = clientID
        self.scope             = scope
        self.username          = username
        self.password          = password
        self.countryCode       = countryCode
        self.vfTargetStub      = vfTargetStub
        self.grantType         = grantType
        self.contentType       = contentType
    }

    // for login authentication
    public init(authenticationBaseUrl: String?,
                authenticationPathUrl: String?,
                grantType: String,
                clientID: String,
                accept: String,
                acceptLanguage: String,
                vFEXTBPID: String?,
                countryCode: String?,
                vfTargetStub: String?,
                contentType: String?,
                code: String) {
        self.authenticationBaseUrl  = authenticationBaseUrl
        self.authenticationPathUrl  = authenticationPathUrl
        self.clientID          = clientID
        self.grantType         = grantType
        self.accept            = accept
        self.acceptLanguage    = acceptLanguage
        self.vFEXTBPID         = vFEXTBPID
        self.countryCode       = countryCode
        self.vfTargetStub      = vfTargetStub
        self.contentType       = contentType
        self.code              = code
        self.scope             = ""
        self.username          = ""
        self.password          = ""
    }
}
