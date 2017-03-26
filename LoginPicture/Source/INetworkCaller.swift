//
//  INetworkCaller.swift
//  LoginPicture
//
//  Created by Michael Wright on 23/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


/**
    Type of the callback function that will be invoked after a network call.
*/
public typealias NetworkCallResponseFunc = (Data?) -> Void


/**
    Contract for a network call.
*/
public protocol INetworkCaller {
    
    // Headers & parameters...
    
    func withHeader(name: String, value: String) -> INetworkCaller
    
    func withParameter(name: String, value: String) -> INetworkCaller

    
    // Body...
    
    func body(_ contents: String) -> INetworkCaller
    
    
    // Authentication...
    
    var authenticator: INetworkAuthenticator? { get }
    
    func authenticate(username: String, password: String) -> INetworkCaller
    
    
    // Call & response...
    
    func get(name: String, callback: @escaping NetworkCallResponseFunc)
    
    func post(name: String, callback: @escaping NetworkCallResponseFunc)
    
    func put(name: String, callback: @escaping NetworkCallResponseFunc)
    
    func delete(name: String, callback: @escaping NetworkCallResponseFunc)
}
