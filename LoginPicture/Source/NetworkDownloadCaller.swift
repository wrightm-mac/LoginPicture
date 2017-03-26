//
//  NetworkDownloadCaller.swift
//  LoginPicture
//
//  Created by Michael Wright on 26/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


open class NetworkDownloadCaller: NetworkCaller, INetworkDownloadCaller {
    
    // MARK:    Overrides...
    
    open override var serviceName: String {
        return "download"
    }
    
    
    // MARK:    Initialisers...
    
    public override init() {
        super.init()
    }
}
