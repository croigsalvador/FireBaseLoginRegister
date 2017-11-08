//
//  XCTExpectationTest.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 8/11/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import XCTest
import Foundation


class BaseExpectationTest: XCTestCase {
    
    var expectation: XCTestExpectation!
    
    func waitForExpectation(with timeout:Double) {
        waitForExpectations(timeout: timeout) { (error) in
            if error != nil {
                print("error")
            }
        }
    }
}
