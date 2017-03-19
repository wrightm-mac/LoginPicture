//
//  ConfigurationValue.swift
//  LoginPicture
//
//  Created by Michael Wright on 19/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


public class ConfigurationValue {
    
    private let value: String
    
    init(value: String?) {
        self.value = value ?? ""
    }
    
    public var string: String {
        return value
    }
    
    public var int: Int {
        return Int(value) ?? 0
    }
    
    public var bool: Bool? {
        return ["true", "yes", "on", "enable"].contains(value.lowercased())
    }
}
