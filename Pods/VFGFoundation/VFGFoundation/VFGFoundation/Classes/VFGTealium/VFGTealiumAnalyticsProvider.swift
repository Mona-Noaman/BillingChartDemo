//
//  VFGTealiumAnalyticsProvider.swift
//  VFGFoundation
//
//  Created by Mohamed ELMeseery on 6/19/19.
//  Copyright © 2019 Vodafone. All rights reserved.
//

public class VFGTealiumAnalyticsProvider: NSObject, VFGAnalyticsProvider {

    public var identifier: String
    var tealiumInstance: AnyObject?

    typealias ConfigurationWithAccountType = @convention(c)(AnyClass?, Selector, String, String, String) -> NSObject?
    typealias NewInstanceFunctionType = @convention(c)(AnyClass?, Selector, String, NSObject?) -> NSObject?

    init(identifier: String) {
        self.identifier = identifier
        super.init()
    }

    public convenience init?(account: String, profile: String, environment: String, identifier: String) {
        let selector: Selector = NSSelectorFromString("configurationWithAccount:profile:environment:")
        guard let tealConfigurationClass: AnyClass = NSClassFromString("TEALConfiguration"),
            let method: Method = class_getClassMethod(tealConfigurationClass, selector) else {
                VFGErrorLog("unable to initialize tealium - no config class")
                return nil
        }
        let methodIMP: IMP! = method_getImplementation(method)
        guard let config: NSObject = unsafeBitCast(methodIMP,
                                                   to: ConfigurationWithAccountType.self)(tealConfigurationClass,
                                                                                          selector,
                                                                                          account,
                                                                                          profile,
                                                                                          environment) else {
                                                                                            return nil
        }
        let selector2: Selector = NSSelectorFromString("newInstanceForKey:configuration:")
        guard let tealiumClass: AnyClass = NSClassFromString("Tealium"),
            let method2: Method = class_getClassMethod(tealiumClass, selector2) else {
                return nil
        }
        let methodIMP2: IMP! = method_getImplementation(method2)
        guard let tealiumInstance: NSObject = unsafeBitCast(methodIMP2,
                                                            to: NewInstanceFunctionType.self)(tealiumClass,
                                                                                              selector,
                                                                                              identifier,
                                                                                              config) else {
                                                                                                return nil
        }
        self.init(identifier: identifier)
        VFGTealiumAnalyticsProvider.trackGroupComponentVersions(instanceId: identifier)
        self.tealiumInstance = tealiumInstance
    }

    public func track(event: String, parameters: [String: Any]?) {
        let selector: Selector = NSSelectorFromString("trackEventWithTitle:dataSources:")
        _ = tealiumInstance?.perform(selector, with: event, with: parameters)
    }
}

extension VFGTealiumAnalyticsProvider {

    static let components: [String: String] = [
        "foundation_version": "VFGFoundation",
        "login_version": "VFGLogin",
        "onboarding_version": "VFGOnboarding",
        "mva10splash_version": "VFGMVA10Splash"
    ]

    static var configuredTealiumInstances: [String] = [String]()

    /**
     Add versions of Vodafone components (linked to application) to Tealium VolatileDataSources
     - Parameter instanceId: Tealium instance identifier
     - Note: Call this method only once. For example after tealium instance has been initialized.
     Subsequent calls will be ignored.
     */
    public class func trackGroupComponentVersions(instanceId: String) {
        if VFGTealiumAnalyticsProvider.configuredTealiumInstances.contains(instanceId) {
            VFGDebugLog("Component versions already added to tealium:\(instanceId)")
            return
        }

        var componentsVersions: [String] = [String]()
        for framework in Bundle.allFrameworks {
            guard let component = VFGTealiumAnalyticsProvider.components.first(where: {
                return framework.bundleIdentifier?.contains($0.value) ?? false
            }) else {
                continue
            }
            componentsVersions.append("\(component.key)_\(framework.appShortVersion)")
        }

        if componentsVersions.isEmpty {
            VFGDebugLog("No VFG components found")
            return
        }
        VFGTealiumAnalyticsProvider.configuredTealiumInstances.append(instanceId)
        guard let tealium = tealiumInstance(with: instanceId) else {
            VFGErrorLog("Failed to access tealiumInstance:\(instanceId)")
            return
        }
        let selector: Selector = NSSelectorFromString("addVolatileDataSources:")
        tealium.perform(selector, with: ["app_vfg_components": componentsVersions])
    }

    class func tealiumInstance(with tealiumID: String) -> NSObject? {
        let selector: Selector = NSSelectorFromString("instanceForKey:")
        if let tealiumClass: AnyClass = NSClassFromString("Tealium"),
            let method: Method = class_getClassMethod(tealiumClass, selector) {
            let methodIMP: IMP! = method_getImplementation(method)
            typealias InstanceForKeyFunctionType = @convention(c)(AnyClass?, Selector, String) -> NSObject
            return unsafeBitCast(methodIMP, to: InstanceForKeyFunctionType.self)(tealiumClass, selector, tealiumID)
        } else {
            return nil
        }
    }
}
