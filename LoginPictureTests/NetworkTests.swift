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
    
    var hook: ((NSMutableURLRequest) -> Void)? = nil
    
    func test(hook: @escaping (NSMutableURLRequest) -> Void) -> NetworkCallerMock {
        self.hook = hook
        
        return self
    }
    
    override func invoke(_ request: NSMutableURLRequest, callback: @escaping NetworkCallResponseFunc) {
        // Don't go out onto the network - just call the testHook callback function
        // passing the URLRequest object that (IRL) will be used to service the
        // request.
        // This allows unit-tests to check whether the URLRequest has been correctly
        // set up for a call.
        
        hook?(request)
    }
}


class NetworkTests: XCTestCase {
    
    var caller: NetworkCallerMock! = nil
    
    override func setUp() {
        super.setUp()
        
        // Not necessary to use the dependency-injection container here - but use
        // it as an extra check...
        AppDelegate.container.register(forType: INetworkCaller.self) { _ in NetworkCallerMock() }
        caller = AppDelegate.container.resolve(forType: INetworkCaller.self) as! NetworkCallerMock
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testGet() {
        caller.test {
            urlRequest in
            
            XCTAssert(urlRequest.httpMethod == "GET", "request is GET")
            
            }.get(url: "dummy") { _ in }
    }
    
    func testPost() {
        caller.test {
            urlRequest in
            
            XCTAssert(urlRequest.httpMethod == "POST", "request is POST")
            
            }.post(url: "dummy") { _ in }
    }
    
    func testPut() {
        caller.test {
            urlRequest in
            
            XCTAssert(urlRequest.httpMethod == "PUT", "request is PUT")
            
            }.put(url: "dummy") { _ in }
    }
    
    func testDelete() {
        caller.test {
            urlRequest in
            
            XCTAssert(urlRequest.httpMethod == "DELETE", "request is DELETE")
            
            }.delete(url: "dummy") { _ in }
    }
}
