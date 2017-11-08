//
//  SocialLoginNetworkProviderFactoryTests.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 3/11/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import XCTest
@testable import FireBaseLoginRegister

class SocialLoginNetworkProviderFactoryTests: BaseExpectationTest {
    
    var mockFacebookSocialProvider: MockSocialNetworkProvider!
    var mockGoogleSocialProvider: MockSocialNetworkProvider!
    var sut: SocialLoginNetworkProviderFactory!
    
    override func setUp() {
        super.setUp()
        mockFacebookSocialProvider = MockSocialNetworkProvider()
        mockGoogleSocialProvider = MockSocialNetworkProvider()
        mockGoogleSocialProvider.isFacebook = false
        sut = SocialLoginNetworkProviderFactory(mockFacebookSocialProvider,mockGoogleSocialProvider)
        expectation  = self.expectation(description: "Expecting Google connect returns user")
    }
    
    override func tearDown() {
        super.tearDown()
        mockFacebookSocialProvider = nil
        mockGoogleSocialProvider = nil
        sut = nil
    }
    
    func testConnect_ShouldCallProviderConnectMethod() {
        
        sut.connect(.facebook) { (request, error) in
            XCTAssertTrue(self.mockFacebookSocialProvider.connectCalled)
            self.expectation.fulfill()
        }
        waitForExpectation(with: 1.0)
    }
    
    func testConnect_ShouldCallGoogleProviderConnectMethod() {
        sut.connect(.google) { (request, error) in
            XCTAssertTrue(self.mockGoogleSocialProvider.connectCalled)
            self.expectation.fulfill()
        }
        waitForExpectation(with: 1.0)
    }
    

    
}
