//
//  Container.swift
//  LoginPicture
//
//  Created by Michael Wright on 19/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


/**
    *Dependency Injection* container.

    Based on, but much more limited than, the `Swinject` Cocoapod.

    Note that the Types are are registered by their name, so resolving a Type will
    only succeed if the exact same Type (regardless of inheritance and implementation)
    is used for both `register` and `resolve` calls.
*/
open class Container {
    
    typealias RegistrationFunc = (Container) -> Void
    
    
    // MARK:    Fields...
    
    private var types: [String: Any] = [:]
    
    
    // MARK:    Initialisers...
    
    public init() {
    }
    
    public init(registrationFunc: RegistrationFunc) {
        registrationFunc(self)
    }
    
    
    // MARK:    Methods...
    
    /**
        Register a type to be dynamically resolved.
     
        - parameter forType: Type be dynamically resolved.
        - parameter callback: Function that will dynamically generate object of
                                class `forType`.
    */
    open func register<T>(forType: T.Type, callback: @escaping () -> T) {
        types[getName(forType)] = callback
    }
    
    /**
        Get a dynamically generated object of a Type.
     
        The Type must have been previously registered with a call to `register<T>(...)`
     
        - parameter forType:   Type to be dynamically resolved.
        - returns: Object of Type, or `nil` if the Type could not be resolved.
    */
    open func resolve<T>(forType: T.Type) -> T? {
        guard let creatorFunc = types[getName(forType)] as? (() -> T) else {
            return nil
        }
        
        return creatorFunc()
    }
    
    
    private func getName<T>(_ forType: T.Type) -> String {
        return String(describing: forType)
    }
}
