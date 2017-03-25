//
//  StringExtensions.swift
//  LoginPicture
//
//  Created by Michael Wright on 25/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


public extension String {
    
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
    public var fromBase64: String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
}
