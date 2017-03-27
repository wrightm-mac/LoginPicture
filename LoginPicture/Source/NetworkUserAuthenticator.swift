//
//  NetworkUserAuthenticator.swift
//  LoginPicture
//
//  Created by Michael Wright on 25/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


open class NetworkUserAuthenticator: INetworkAuthenticator {
    
    // MARK:    Fields...
    
    public var username: String
    
    public var password: String
    
    
    // MARK:    Initialiser...
    
    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }
    
    
    // MARK:    'INetworkAuthenticator'...
    
    open func authenticate(with caller: INetworkCaller) {
        _ = caller.withParameter(name: "username", value: username)
                  .withHeader(name: "authorization", value: password.sha1.hex)
                  .body(content: "username=\(username)")
    }
}
