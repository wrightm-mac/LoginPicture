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
        let typeName = "\(type(of: forType))"
        
        types[typeName] = callback
    }
    
    /**
        Get a dynamically generated object of a Type.
     
        The Type must have been previously registered with a call to `register<T>(...)`
     
        - parameter forType:   Type to be dynamically resolved.
        - returns: Object of Type, or `nil` if the Type could not be resolved.
    */
    open func resolve<T>(forType: T.Type) -> T? {
        let typeName = "\(type(of: forType))"

        guard let creatorFunc = types[typeName] as? (() -> T) else {
            return nil
        }
        
        return creatorFunc()
    }
}
