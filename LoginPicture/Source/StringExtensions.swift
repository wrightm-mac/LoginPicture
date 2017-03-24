//
//  StringExtensions.swift
//  LoginPicture
//
//  Created by Michael Wright on 24/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


public extension String {
    
    public var utf8Data: Data {
        return data(using: String.Encoding.utf8)!
    }
    
    public var sha1: Sha1 {
        return Sha1(from: utf8Data)
    }
}
