//
//  INetworkAuthenticator.swift
//  LoginPicture
//
//  Created by Michael Wright on 23/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


public protocol INetworkAuthenticator {
    
    func authenticate(with: INetworkCaller)
}
