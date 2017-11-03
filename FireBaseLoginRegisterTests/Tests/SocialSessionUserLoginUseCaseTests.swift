//
//  SocialSessionUserLoginUseCaseTests.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 27/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import XCTest
@testable import FireBaseLoginRegister

class SocialSessionUserLoginUseCaseTests: XCTestCase {
    
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
        
        sut = SocialSessionUserLogin.init(notificationCenter:mockNotificationCenter, socialProviderFactory: stubSocialProviderFactory, sessionProvider:mockSessionUserProvider, sessionPersistor: mockSessionPersistor)
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
        let expectation = self.expectation(description: "Expecting factory connect return")
        stubSocialProviderFactory.error =  NSError(domain:"", code:4, userInfo:nil)
        sut.connect(.facebook) { (success) in
            XCTAssert(!success)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 0.5) { (error) in
            if error != nil {
                print("error")
            }
        }
    }
    
    func testConnect_ShouldCallSessionNetworkProviderRegisterMethodAndReturnFalseInSuccess() {
        let expectation = self.expectation(description: "Expecting factory connect return")
        mockSessionUserProvider.error = NSError(domain:"", code:4, userInfo:nil)
        sut.connect(.facebook) { (success) in
            XCTAssert(!success)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0) { (error) in
            if error != nil {
                print("error")
            }
        }
    }
    
    func testConnect_ShouldCallSessionPersitorAndReturnFalseInSuccessClousure(){
        let expectation = self.expectation(description: "Expecting factory connect return")
        sut.connect(.facebook) { (success) in
            XCTAssert(!success)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0) { (error) in
            if error != nil {
                print("error")
            }
        }
    }
    
    func testConnect_ShouldCallSessionPersitorAndCallNotificationUserDidLoginMethod() {
        let expectation = self.expectation(description: "Expecting factory connect return")
        mockSessionPersistor.success = true
        sut.connect(.facebook) { (success) in
            XCTAssertTrue(self.mockNotificationCenter.postCalled > 0)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0) { (error) in
            if error != nil {
                print("error")
            }
        }
    }
    
}
