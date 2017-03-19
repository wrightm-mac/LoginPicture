//
//  ILogWriter.swift
//  LoginPicture
//
//  Created by Michael Wright on 19/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


/**
    Contract for a log writer.
 
    Implement for `Logger` class.
*/
public protocol ILogWriter {
    
    /**
     Writes a message to the log.
     
     - parameter message: Message to write to log.
    */
    func log(_ message: String)
}
