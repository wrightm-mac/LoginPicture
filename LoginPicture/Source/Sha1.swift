//
//  Sha1.swift
//  LoginPicture
//
//  Created by Michael Wright on 24/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


/**
    Gives a byte-array of SHA-1 encrypted string.

    From `http://stackoverflow.com/questions/25761344/how-to-crypt-string-to-sha1-with-swift`.
*/
open class Sha1 {
    
    // MARK:    Fields...
    
    private var buffer: [UInt8]
    
    
    // MARK:    Initialisers...
    
    public init(from: Data) {
        buffer = [UInt8](repeating: 0, count:Int(CC_SHA1_DIGEST_LENGTH))
        from.withUnsafeBytes { _ = CC_SHA1($0, CC_LONG(from.count), &buffer) }
    }
    
    public convenience init(from: String) {
        self.init(from: from.utf8Data)
    }
    
    
    // MARK:    Conversions...
    
    open var uint8Array: [UInt8] {
        return buffer
    }
    
    open var hex: String {
        return buffer.map { String(format: "%02hhx", $0) }.joined()
    }
    
    open var base64: String {
        return Data(bytes: buffer).base64EncodedString()
    }
}
