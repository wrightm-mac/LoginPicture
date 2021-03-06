//
//  StringExtensions.swift
//  LoginPicture
//
//  Created by Michael Wright on 25/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


public extension String {
    
    public func toData(using: String.Encoding = .utf8, allowLossyConversion: Bool = false) -> Data? {
        return self.data(using: using, allowLossyConversion: allowLossyConversion)
    }
    
    /**
     Base64 encode.
     
     From `stackoverflow.com/questions/29365145/how-to-encode-string-to-base64-in-swift`.
     */
    public var toBase64: String {
        return Data(self.utf8).base64EncodedString()
    }

    /**
        Base64 decode.
     
        From `stackoverflow.com/questions/29365145/how-to-encode-string-to-base64-in-swift`.
    */
    public var fromBase64: Data? {
        return Data(base64Encoded: self)
    }
}
