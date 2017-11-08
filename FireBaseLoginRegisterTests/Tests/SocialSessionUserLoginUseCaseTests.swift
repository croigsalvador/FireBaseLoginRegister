//
//  SocialSessionUserLoginUseCaseTests.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 27/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import XCTest
@testable import FireBaseLoginRegister

class SocialSessionUserLoginUseCaseTests: BaseExpectationTest {
    
    var sut: SocialSessionUserLoginUseCase!
    var mockNotificationCenter: MockNotificationCenter!
    var stubSocialProviderFactory: StubSocialLoginNetworkProviderFactory!
    var mockSessionUserProvider: MockSessionUserNetworkProvider!
    var mockSessionPersistor: MockUserSessionPersistor!
    
    override func setUp() {
        super.setUp()
        mockNotificationCenter = MockNotificationCenter()
        let dummieFacebookProvider = DummyFactory.dummy(someClass:FacebookLoginNetworkProvider.self)
        let dummieGoogleProvider = DummyFactory.dummy(someClass:GoogleLoginNetworkProvider.self)
        stubSocialProviderFactory = StubSocialLoginNetworkProviderFactory(dummieFacebookProvider,dummieGoogleProvider)
        mockSessionUserProvider = MockSessionUserNetworkProvider()
        mockSessionPersistor = MockUserSessionPersistor()
        
        sut = SocialSessionUserLogin.init(notificationCenter: mockNotificationCenter,
                                          socialProviderFactory: stubSocialProviderFactory,
                                          sessionProvider: mockSessionUserProvider,
                                          sessionPersistor: mockSessionPersistor)
        expectation  = self.expectation(description: "Expecting Google connect returns user")
    }
    
    override func tearDown() {
        mockNotificationCenter = nil
        stubSocialProviderFactory = nil
        mockSessionUserProvider = nil
        mockSessionPersistor = nil
        sut = nil
        super.tearDown()
    }
    
    func testConnect_ShouldCallFactoryConnectMethodAndReturnFalseInSuccess() {
        stubSocialProviderFactory.error =  NSError(domain:"", code:4, userInfo:nil)
        sut.connect(.facebook) { (success) in
            XCTAssert(!success)
            self.expectation.fulfill()
        }
        waitForExpectation(with: 1.0)
    }
    
    func testConnect_ShouldCallSessionNetworkProviderRegisterMethodAndReturnFalseInSuccess() {
        mockSessionUserProvider.error = NSError(domain:"", code:4, userInfo:nil)
        sut.connect(.facebook) { (success) in
            XCTAssert(!success)
            self.expectation.fulfill()
        }
        waitForExpectation(with: 1.0)
    }
    
    func testConnect_ShouldCallSessionPersitorAndReturnFalseInSuccessClousure(){
        sut.connect(.facebook) { (success) in
            XCTAssert(!success)
            self.expectation.fulfill()
        }
        waitForExpectation(with: 1.0)

    }
    
    func testConnect_ShouldCallSessionPersitorAndCallNotificationUserDidLoginMethod() {
        mockSessionPersistor.success = true
        sut.connect(.facebook) { (success) in
            XCTAssertTrue(self.mockNotificationCenter.postCalled > 0)
            self.expectation.fulfill()
        }
        waitForExpectation(with: 1.0)
    }
    
}
