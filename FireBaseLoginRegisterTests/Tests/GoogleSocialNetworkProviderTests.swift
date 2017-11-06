//
//  GoogleSocialNetworkProviderTests.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 6/11/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import XCTest
@testable import FireBaseLoginRegister

class GoogleSocialNetworkProviderTests: XCTestCase {
    
    var sut: GoogleLoginNetworkProvider!
    var mockViewController: MockViewController!
    var mockGDSignIn: MockGoogleSignIn!
    
    
    override func setUp() {
        super.setUp()
        mockViewController = MockViewController()
        mockGDSignIn = MockGoogleSignIn()
        sut = GoogleLoginNetworkProvider(manager: mockGDSignIn, view: mockViewController)
    }
    
    override func tearDown() {
        super.tearDown()
        mockGDSignIn = nil
        mockViewController = nil
        sut = nil
    }
    
    private func fakeGoogleUser() -> StubGoogleUser
    
    func testConnect_ShouldCallPresentViewControllerMethod() {
        sut.connectUser { (user, error) in }
        XCTAssertTrue(mockViewController.presentCalled)
    }
    
    func testConnect_ShouldCallCompletionHandlerWithError() {
        let expectation = self.expectation(description: "Expecting Google connect returns user")
        mockGDSignIn.error =  NSError(domain:"", code:4, userInfo:nil)
        sut.connectUser { (user, error) in
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0) { (error) in
            if error != nil {
                print("error")
            }
        }
    }
    
    func testConnect_ShouldCallCompletionHandlerWithOutError() {
        let expectation = self.expectation(description: "Expecting Google connect returns user")
        sut.connectUser { (user, error) in
            XCTAssertNil(error)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0) { (error) in
            if error != nil {
                print("error")
            }
        }
    }


    
}
