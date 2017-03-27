//
//  NetworkTokenAuthenticator.swift
//  LoginPicture
//
//  Created by Michael Wright on 27/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


open class NetworkTokenAuthenticator: INetworkAuthenticator {
    
    // MARK:    Fields...
    
    public var token: String
    
    
    // MARK:    Initialiser...
    
    public init(token: String) {
        self.token = token
    }
    
    
    // MARK:    'INetworkAuthenticator'...
    
    open func authenticate(with caller: INetworkCaller) {
        _ = caller.withHeader(name: "Auth-Token", value: token.sha1.hex)
    }
}
