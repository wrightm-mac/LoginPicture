//
//  NetworkTests.swift
//  LoginPicture
//
//  Created by Michael Wright on 27/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import XCTest
@testable import LoginPicture


class NetworkCallerMock: NetworkCaller {
    
    var hook: ((URLRequest?) -> Void)? = nil
    
    func testHook(hook: @escaping (URLRequest?) -> Void) -> NetworkCallerMock {
        self.hook = hook
        
        return self
    }
    
    override func invoke(httpMethod: String, fullPath: String, headers: [String : String], body: String, callback: @escaping NetworkCallResponseFunc) {
        // Don't go out onto the network - just call the testHook callback function
        // passing the URLRequest object that (IRL) will be used to service the
        // request.
        // This allows unit-tests to check whether the URLRequest has been correctly
        // set up for a call.
        
        hook?(nil)
    }
}


class NetworkTests: XCTestCase {
    
    var caller: NetworkCallerMock! = nil
    
    override func setUp() {
        super.setUp()
        
        AppDelegate.container.register(forType: INetworkCaller.self) { _ in NetworkCallerMock() }
        caller = AppDelegate.container.resolve(forType: INetworkCaller.self) as! NetworkCallerMock
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGet() {
        caller.withParameter(name: "First", value: "One")
            .testHook {
                urlRequest in
                
                XCTAssert(urlRequest.httpMethod == "GET", "request is GET")
                
            }.get(url: "dummy") { _ in }
    }
}
