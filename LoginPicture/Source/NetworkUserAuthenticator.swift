//
//  NetworkUserAuthenticator.swift
//  LoginPicture
//
//  Created by Michael Wright on 25/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


open class NetworkUserAuthenticator: INetworkAuthenticator {
    
    open func authenticate(with caller: INetworkCaller, username: String, password: String) {
        _ = caller.withParameter(name: "username", value: username)
                  .withHeader(name: "authorization", value: password.sha1.hex)
    }
}
