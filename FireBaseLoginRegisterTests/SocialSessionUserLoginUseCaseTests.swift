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
    var notificationCenter: NotificationCenter!
    var stubSocialProviderFactory: StubSocialLoginNetworkProviderFactory!
    var mockSessionUserProvider: MockSessionUserNetworkProvider!
    var mockSessionPersistor: MockUserSessionPersistor!
    
    
    override func setUp() {
        super.setUp()
        notificationCenter = NotificationCenter.default
        stubSocialProviderFactory = StubSocialLoginNetworkProviderFactory(view:UIViewController())
        mockSessionUserProvider = MockSessionUserNetworkProvider()
        mockSessionPersistor = MockUserSessionPersistor(PlistStorageCoordinator("Fake", ItemSerializer()))
        
        sut = SocialSessionUserLogin.init(notificationCenter:notificationCenter, socialProviderFactory: stubSocialProviderFactory, sessionProvider:mockSessionUserProvider, sessionPersistor: mockSessionPersistor)
    }
    
    func testConnect_ShouldReturNotSuccessWhenErrorIsReturnedFromNetworkTask() {
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
    
    func testConnect_ShouldCallSessionNetworkProviderRegisterMethod() {
        let expectation = self.expectation(description: "Expecting factory connect return")
        sut.connect(.facebook) { (success) in
            XCTAssert(self.mockSessionUserProvider.called)
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0) { (error) in
            if error != nil {
                print("error")
            }
        }
    }
    
    
}
