//
//  AuthRequest.swift
//  VFGFoundation
//
//  Created by Esraa Eldaltony on 10/24/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

import Foundation

enum AuthRequest: VFGRequestProtocol {

    static let base = "https://eu2-stagingref.api.vodafone.com"
    static var path = "/v1/apixoauth2password/oauth2/token"
    case getToken(authObject: Authentication)
    case refreshToken(authObject: Authentication, refreshToken: String)
    case getSoftLoginToken(authObject: Authentication)

    var path: String {
        return AuthRequest.path
    }

    var httpMethod: HTTPMethod {
        return .post
    }

    var httpTask: HTTPTask {
        var params: Parameters?
        var headers: [String: String]?

        switch self {
        case .getToken(authObject: let object):
            params = [RequestParameterKey.clientIDKey: object.clientID ?? VFGDxlConstants.shared.clientID,
                      RequestParameterKey.grantTypeKey: object.grantType ?? "",
                      RequestParameterKey.usernameKey: object.username ?? "",
                      RequestParameterKey.passwordKey: object.password ?? "",
                      RequestParameterKey.scopeKey: object.scope ?? ""
            ]
            headers = [
                RequestHeaderKey.contentTypeKey: object.contentType ?? "application/x-www-form-urlencoded",
                RequestHeaderKey.countryCodeKey: object.countryCode ?? VFGDxlConstants.shared.countryCode,
                RequestHeaderKey.vftargetStub: object.vfTargetStub ?? "true"]

        case .refreshToken(authObject: let object, refreshToken: let refreshToken):
            headers = [RequestHeaderKey.vftargetStub: object.vfTargetStub ?? "true"]

            params = [RequestParameterKey.grantTypeKey: "refresh_token",
                      RequestParameterKey.clientIDKey: object.clientID ?? VFGDxlConstants.shared.clientID,
                      RequestParameterKey.scopeKey: object.scope ?? "",
                      RequestParameterKey.refreshTokenKey: refreshToken
            ]

        case .getSoftLoginToken(authObject: let object) :
            params = [RequestParameterKey.clientIDKey: object.clientID ?? VFGDxlConstants.shared.clientID,
                      RequestParameterKey.grantTypeKey: object.grantType ?? "",
                      RequestParameterKey.codeKey: object.code ?? ""
            ]
            headers = [
                RequestHeaderKey.acceptKey: object.accept ?? "application/json",
                RequestHeaderKey.contentTypeKey: object.contentType ?? "application/x-www-form-urlencoded",
                RequestHeaderKey.acceptLanguageKey: object.acceptLanguage ?? "GR",
                RequestHeaderKey.vfEXTBPIDKey: object.vFEXTBPID ?? "TC01",
                RequestHeaderKey.vftargetStub: object.vfTargetStub ?? "true"]

        }
        return .requestParametersAndHeaders(bodyParameters: params,
                                            bodyEncoding: .jsonEncoding,
                                            urlParameters: nil,
                                            extraHeaders: headers)
    }

    var headers: HTTPHeaders? {
        return [:]
    }

    var isAuthenticationNeededRequest: Bool? {
        return false
    }

    var cachePolicy: CachePolicy {
        return .reloadIgnoringLocalAndRemoteCacheData
    }

}

public enum VFGAuthenticationError: String, Error {
    case authenticationObjectNil      = "Authentication Object is nil"
    case authenticationObjectOrTokenNil      = "Authentication Object is nil or there's not saved token"
}
