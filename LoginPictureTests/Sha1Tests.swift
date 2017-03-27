//
//  Sha1Tests.swift
//  LoginPicture
//
//  Created by Michael Wright on 27/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import XCTest
@testable import LoginPicture


class Sha1Tests: XCTestCase {
    
    let sample = "thequickbrownfox"
    let hex = "97c27c6a5588cc2b9891d9d256f38c41bb759b3f"
    let base64 = "l8J8alWIzCuYkdnSVvOMQbt1mz8="
    
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testBuffer() {
        let sha1Buffer = sample.sha1.uint8Array
        
        XCTAssert(sha1Buffer.count == 20, "sha1 buffer is correct size")
    }
    
    func testHex() {
        XCTAssert(sample.sha1.hex == hex, "sha1 hex is correct")
    }
    
    func testBase64() {
        XCTAssert(sample.sha1.base64 == base64, "sha1 base64 is correct")
    }
}
