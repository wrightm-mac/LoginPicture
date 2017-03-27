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
    
    
    // Calling...
    
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
    
    
    // URLs...
    
    func testUrl() {
        let serviceName = "MyService"
        
        caller.test {
            urlRequest in
            
                XCTAssert((urlRequest.url?.absoluteString.hasSuffix("/\(serviceName)")) ?? false, "url is correctly terminated")
            
            }.get(url: serviceName) { _ in }
    }
    
    
    // Parameters & Headers...
    
    func testParameter() {
        let parameterName = "First"
        let parameterValue = "One"
        
        caller
            .test {
            urlRequest in
            
                XCTAssert((urlRequest.url?.absoluteString.hasSuffix("?\(parameterName)=\(parameterValue)")) ?? false, "url contains parameter")
            
            }
            .withParameter(name: parameterName, value: parameterValue)
            .get(url: "DummyEndpoint") { _ in }
    }
    
    func testHeader() {
        let headerName = "Second"
        let headerValue = "Two"
        
        caller
            .test {
                urlRequest in
                
                XCTAssert(urlRequest.allHTTPHeaderFields?.keys.contains(headerName) ?? false, "urlRequest contains header")
                XCTAssert(urlRequest.allHTTPHeaderFields?[headerName] == headerValue, "urlRequest header is correct value")
            }
            .withHeader(name: headerName, value: headerValue)
            .get(url: "DummyEndpoint") { _ in }
    }
    
    
    // Authentication...
    
    func testUserAuthentication() {
        let username = "Johnny"
        let password = "Alpha"
        
        caller
            .test {
                urlRequest in
                
                XCTAssert((urlRequest.url?.absoluteString.hasSuffix("?username=\(username)")) ?? false, "url contains 'username' parameter")
                
                XCTAssert(urlRequest.allHTTPHeaderFields?.keys.contains("Authorization") ?? false, "urlRequest contains 'Authorization' header")
                XCTAssert(urlRequest.allHTTPHeaderFields?["Authorization"] == password.sha1.hex, "urlRequest 'Authorization' header is correct value")
                
                XCTAssert(urlRequest.httpBody?.toString() == "username=\(username)", "urlRequest body has correct contents")
            }
            .authenticate(with: NetworkUserAuthenticator(username: username, password: password))
            .get(url: "DummyEndpoint") { _ in }
    }
    
    func testTokenAuthentication() {
        let token = "thequickbrownfoxjumpsoverthelazydog"
        
        caller
            .test {
                urlRequest in
                
                XCTAssert(urlRequest.allHTTPHeaderFields?.keys.contains("Auth-Token") ?? false, "urlRequest contains 'Auth-Token' header")
                XCTAssert(urlRequest.allHTTPHeaderFields?["Auth-Token"] == token.sha1.hex, "urlRequest 'Auth-Token' header is correct value")
            }
            .authenticate(with: NetworkTokenAuthenticator(token: token))
            .get(url: "DummyEndpoint") { _ in }
    }
}
