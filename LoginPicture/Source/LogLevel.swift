//
//  LogLevel.swift
//  LoginPicture
//
//  Created by Michael Wright on 19/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


public enum LogLevel: String {
    
    case debug = "debug"
    case info = "info"
    case event = "event"
    case warn = "warn"
    case error = "error"
    
    
    public var defaultPrefix: String {
        switch self {
            case .debug: return "😗 -debug->"
            case .info: return "😁 -info-->"
            case .event: return "😎 -event->"
            case .warn: return "😡 -warn-->"
            case .error: return "💩 -error->"
        }
    }
}
