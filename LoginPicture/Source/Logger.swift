//
//  Logger.swift
//  LoginPicture
//
//  Created by Michael Wright on 19/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


/**
    Very simple logging.
 
    A (very) logging class based on the interface of the *Willow* logging CocoaPod.
 
    Currently only writes to console. Implement a custom `ILogWriter` for enhanced
    functionality.
*/
open class Logger {
    
    // MARK:    Singleton...
    
    private static var _instance = Logger()
    
    open static var instance: Logger {
        return _instance
    }
    
    
    // MARK:    Fields...
    
    private var writers: [LogLevel: ILogWriter] = [
        .error: ConsoleLogWriter(prefix: "error:")
    ]
    
    
    // MARK:    Initialisers...
    
    private init() {
        let configuration = Configuration()
        let logLevelSetting = configuration["LogLevel"].string
        let logLevels = logLevelSetting.components(separatedBy: ",")
        
        for logLevel in logLevels {
            let level = LogLevel(rawValue: logLevel)!
            writers[level] = ConsoleLogWriter(prefix: level.defaultPrefix)
        }
    }
    
    
    // MARK:    Behaviours...
    
    /**
     Write a `debug` message to the log.
     
     Message is only written, meaning the `callback` function is only called,
     if `debug` level logging is enabled.
     
     - parameter callback: Function of type `() -> String` that returns message to be logged.
     */
    open func debug(_ callback: @autoclosure @escaping () -> String = "", callingFunction: String = #function) {
        if let writer = writers[.debug] {
            writer.log("\(callingFunction) \(callback())")
        }
    }
    
    /**
     Write a `info` message to the log.
     
     Message is only written, meaning the `callback` function is only called,
     if `info` level logging is enabled.
     
     - parameter callback: Function of type `() -> String` that returns message to be logged.
     */
    open func info(_ callback: @autoclosure @escaping () -> String = "", callingFunction: String = #function) {
        if let writer = writers[.info] {
            writer.log("\(callingFunction) \(callback())")
        }
    }
    
    /**
     Write an `event` message to the log.
     
     Message is only written, meaning the `callback` function is only called,
     if `event` level logging is enabled.
     
     - parameter callback: Function of type `() -> String` that returns message to be logged.
     */
    open func event(_ callback: @autoclosure @escaping () -> String = "", callingFunction: String = #function) {
        if let writer = writers[.event] {
            writer.log("\(callingFunction) \(callback())")
        }
    }
    
    /**
     Write a `warn` message to the log.
     
     Message is only written, meaning the `callback` function is only called,
     if `warn` level logging is enabled.
     
     - parameter callback: Function of type `() -> String` that returns message to be logged.
     */
    open func warn(_ callback: @autoclosure @escaping () -> String = "", callingFunction: String = #function) {
        if let writer = writers[.warn] {
            writer.log("\(callingFunction) \(callback())")
        }
    }
    
    /**
     Write an `error` message to the log.
     
     Message is only written, meaning the `callback` function is only called,
     if `error` level logging is enabled.
     
     - parameter callback: Function of type `() -> String` that returns message to be logged.
     */
    open func error(_ callback: @autoclosure @escaping () -> String = "", callingFunction: String = #function) {
        if let writer = writers[.error] {
            writer.log("\(callingFunction) \(callback())")
        }
    }
}
