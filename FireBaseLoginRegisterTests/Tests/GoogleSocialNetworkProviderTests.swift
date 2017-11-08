//
//  GoogleSocialNetworkProviderTests.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 6/11/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import XCTest
@testable import FireBaseLoginRegister

class GoogleSocialNetworkProviderTests: BaseExpectationTest {
    
    var sut: GoogleLoginNetworkProvider!
    var mockViewController: MockViewController!
    var mockGDSignIn: MockGoogleSignIn!
    
    
    override func setUp() {
        super.setUp()
        mockViewController = MockViewController()
        mockGDSignIn = MockGoogleSignIn()
        sut = GoogleLoginNetworkProvider(manager: mockGDSignIn, view: mockViewController)
        expectation  = self.expectation(description: "Expecting Google connect returns user")
    }
    
    override func tearDown() {
        super.tearDown()
        mockGDSignIn = nil
        mockViewController = nil
        sut = nil
    }
    
    private var fakeGoogleUser : FakeGoogleUser {
        return FakeGoogleUser()
    }
    
    func testConnect_ShouldCallPresentViewControllerMethod() {
        sut.connectUser { (_, _) in}
        XCTAssertTrue(mockViewController.presentCalled)
    }
    
    func testConnect_ShouldCallCompletionHandlerWithError() {
        mockGDSignIn.error =  NSError(domain:"", code:4, userInfo:nil)
        sut.connectUser { (_, error) in
            XCTAssertNotNil(error)
            self.expectation.fulfill()
        }
        waitForExpectation(with: 1.0)
    }
    
    func testConnect_ShouldCallCompletionHandlerWithOutErrorAndReturningSocialRequestModel() {
        mockGDSignIn.googleUser = fakeGoogleUser
        sut.connectUser { (request,_) in
            XCTAssertNotNil(request)
            XCTAssertTrue(self.fakeGoogleUser.authentication.accessToken == request?.token)
            self.expectation.fulfill()
        }
        waitForExpectation(with: 1.0)
    }


    
}
