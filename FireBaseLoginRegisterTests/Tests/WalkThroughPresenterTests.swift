//
//  WalkThroughPresenterTests.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 27/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import XCTest
import Firebase
@testable import FireBaseLoginRegister

class WalkThroughPresenterTests: XCTestCase {
    
    fileprivate var sut: WalkThroughPresenter!
    fileprivate var stubNavigator: StubWalkthroughNavigator!
    fileprivate var stubSocialSession: StubSocialSessionUserLoginUseCase!
    
    override func setUp() {
        super.setUp()
        stubNavigator = StubWalkthroughNavigator()
        stubSocialSession = StubSocialSessionUserLoginUseCase()
        sut = WalkThroughPresenter.init(navigator:stubNavigator, socialSession:stubSocialSession)
    }
    
    func testGoogle_shouldCallSocialConnectConnectionMethod(){
        sut.google()
        XCTAssert(stubSocialSession.connectCalled)
    }
    func testFacebook_shouldCallSocialConnectConnectionMethod(){
        sut.facebook()
        XCTAssert(stubSocialSession.connectCalled)
    }
    
    func testLogin_shouldCallOpenLogin(){
        sut.login()
        XCTAssert(stubNavigator.didOpenLogin)
    }
    
    func testRegister_shouldCallOpenLogin(){
        sut.register()
        XCTAssert(stubNavigator.didOpenRegister)
    }
    
}

