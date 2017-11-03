//
//  SocialLoginNetworkProviderFactoryTests.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 3/11/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import XCTest
@testable import FireBaseLoginRegister

class SocialLoginNetworkProviderFactoryTests: XCTestCase {
    
    var mockFacebookSocialProvider: MockSocialNetworkProvider!
    var mockGoogleSocialProvider: MockSocialNetworkProvider!
    var sut: SocialLoginNetworkProviderFactory!
    
    override func setUp() {
        super.setUp()
        mockFacebookSocialProvider = MockSocialNetworkProvider()
        mockGoogleSocialProvider = MockSocialNetworkProvider()
        mockGoogleSocialProvider.isFacebook = false
        sut = SocialLoginNetworkProviderFactory(mockFacebookSocialProvider,mockGoogleSocialProvider)
    }
    
    override func tearDown() {
        super.tearDown()
        mockFacebookSocialProvider = nil
        mockGoogleSocialProvider = nil
        sut = nil
    }
    
    func testConnect_ShouldCallFacebookProviderConnectMethod() {
        let expectation = self.expectation(description: "Expecting factory connect return")
        sut.connect(.facebook) { (request, error) in
            XCTAssertTrue(self.mockFacebookSocialProvider.connectCalled)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0) { (error) in
            if error != nil {
                print("error")
            }
        }
    }
    
    func testConnect_ShouldCallGoogleProviderConnectMethod() {
        let expectation = self.expectation(description: "Expecting factory connect return")
        sut.connect(.google) { (request, error) in
            XCTAssertTrue(self.mockGoogleSocialProvider.connectCalled)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 1.0) { (error) in
            if error != nil {
                print("error")
            }
        }
    }
    

    
}
