//
//  ContainerTests.swift
//  LoginPicture
//
//  Created by Michael Wright on 21/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import XCTest
@testable import LoginPicture


class ContainerTests: XCTestCase {
    
    var container: Container! = nil
    
    
    let stringValue = "yada yada yada!"
    let intValue = 2108
    
    
    override func setUp() {
        super.setUp()
        
        container = Container() {
            container in
            
            container.register(forType: String.self) { self.stringValue }
            container.register(forType: Int.self) { self.intValue }
        }
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testResolveSuccessNonNil() {
        XCTAssertNotNil(container.resolve(forType: Int.self), "resolve Int success not nil")
        XCTAssertNotNil(container.resolve(forType: String.self), "resolve String success not nil")
    }
    
    func testResolveSuccessWithValue() {
        XCTAssert(container.resolve(forType: Int.self) == self.intValue, "resolve Int success with value")
        XCTAssert(container.resolve(forType: String.self) == self.stringValue, "resolve String success with value")
    }
    
    func testResolveFailureWithNil() {
        XCTAssertNil(container.resolve(forType: Float.self), "resolve failure with nil")
    }
    
    func testRegisterOutsideConstructor() {
        container.register(forType: Double.self) { 123.456 }
        XCTAssertNotNil(container.resolve(forType: Int.self), "resolve Double success registered")
    }
}
