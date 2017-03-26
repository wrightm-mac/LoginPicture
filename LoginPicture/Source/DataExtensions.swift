//
//  DataExtensions.swift
//  LoginPicture
//
//  Created by Michael Wright on 26/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


extension Data {
    
    public func toString(encoding: String.Encoding = .utf8) -> String? {
        return String(data: self, encoding: encoding)
    }
    
    public var json: [String: AnyObject]? {
        do {
            return try JSONSerialization.jsonObject(with: self) as? [String: AnyObject]
        }
        catch {
            return nil
        }
    }
}
