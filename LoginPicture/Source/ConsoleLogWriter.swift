//
//  ConsoleLogger.swift
//  LoginPicture
//
//  Created by Michael Wright on 19/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


/**
    Writes log messages to the console.
 
*/
open class ConsoleLogWriter: ILogWriter {
    
    // MARK:    Fields...
    
    private var prefix: String
    
    
    // MARK:    Initialisers...
    
    /**
        Initialiser.
     
        - parameter prefix: String to be prepended to all log messages.
    */
    public init(prefix: String) {
        self.prefix = prefix
    }
    
    
    // MARK:    Methods...
    
    /**
        Writes a log message.
     
        - parameter message:    Message to be logged.
    */
    open func log(_ message: String) {
        print("\(prefix) \(message)")
    }
}
