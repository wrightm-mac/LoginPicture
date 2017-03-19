//
//  Configuration.swift
//  LoginPicture
//
//  Created by Michael Wright on 19/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


open class Configuration {
    
    // MARK:    Fields...
    
    private let configuration: [String: String]
    
    
    // MARK:    Initialisers...
    
    public convenience init() {
        self.init(file: "Configuration")
    }
    
    public init(file: String, forClass: AnyClass = Configuration.self) {
        let filePath = Bundle.init(for: forClass).path(forResource: file, ofType: "plist")!
        configuration = NSDictionary(contentsOfFile: filePath) as! [String : String]
    }
    
    
    // MARK:    Operators...
    
    open subscript(_ name: String) -> ConfigurationValue {
        return ConfigurationValue(value: configuration[name])
    }
}
