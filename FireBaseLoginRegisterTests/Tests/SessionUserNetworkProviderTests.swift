//
//  SessionUserNetworkProviderTests.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 6/11/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import XCTest
@testable import FireBaseLoginRegister

class SessionUserNetworkProviderTests: XCTestCase {
    
    var sut: SessionUserNetworkProvider!
    var mockDatabase: MockFirebaseDatabase!
    var mockAuth: MockFirebaseAuth!
    let fakeUser = FakeFirebaseUser()
    var stubReference = StubFirebaseDatabaseReference()
    
    let loginParams = LoginUserParams(email:"email@gmail.com", password:"12345")
    let registerParams = RegisterUserBasicParams(name:"Name",email:"email@gmail.com", password:"12345")
    let error = NSError(domain:"", code:4, userInfo:nil)
    var expectation: XCTestExpectation!
    
    override func setUp() {
        super.setUp()
        mockDatabase = MockFirebaseDatabase()
        mockDatabase.stubReference = stubReference
        mockAuth = MockFirebaseAuth.auth()
        sut = SessionUserFirebaseProvider.init(mockDatabase,mockAuth)
        expectation  = self.expectation(description: "Expecting Google connect returns user")
        
    }
    
    override func tearDown() {
        super.tearDown()
        expectation = nil
        mockDatabase.stubReference = nil
        mockAuth = nil
        mockDatabase = nil
        sut = nil
 
    }
    
    private func waitForExpectation() {
        waitForExpectations(timeout: 1.0) { (error) in
            if error != nil {
                print("error")
            }
        }
    }
    
    private func checkErrorIn(_ result: RegisterResult) {
        switch result {
        case .success(_):
            break
        case let .failure(error):
            XCTAssertNotNil(error)
        }
        self.expectation.fulfill()
    }
    
    private func checkSuccessIn(_ result: RegisterResult,_ params:RegisterUserBasicParams) {
        switch result {
        case let .success(user):
            XCTAssertTrue(user?.name == params.name)
            XCTAssertTrue(user?.email == params.email)
            break
        case .failure(_):
            break
        }
        expectation.fulfill()
    }
    
    func testRegister_withRegisterParamsShouldReturnErrorForSomethingWroinAuthentication() {
        mockAuth.error = error
        sut.register(registerParams) { (result) in
            self.checkErrorIn(result)
        }
        waitForExpectation()
    }
    
    func testRegister_withRegisterParamsShouldReturnErrorFromUpdatingUser() {
        mockAuth.user = fakeUser
        stubReference.error = error
        sut.register(registerParams) { (result) in
            self.checkErrorIn(result)
        }
        waitForExpectation()
        
    }
    
    func testRegister_withRegisterParamsShouldUserSessionCreatedWithSameEmail() {
        var params = registerParams
        params.email = fakeUser.email!
        mockAuth.user = fakeUser
        sut.register(params) { (result) in
            self.checkSuccessIn(result, params)
        }
        waitForExpectation()
    }
    
    func testLogin_withLoginParamsShouldReturnError() {
        mockAuth.error =  error
        sut.loginUser(loginParams) { (result) in
           self.checkErrorIn(result)
        }
        waitForExpectation()
    }
    
    func testLogin_withLoginParamsShouldReturnErrorFromUpdatingUserInServer() {
        mockAuth.user = fakeUser
        stubReference.error = error
        sut.loginUser(loginParams) { (result) in
           self.checkErrorIn(result)
        }
        waitForExpectation()
    }
    
    func testLogin_withLoginParamsShouldUserSessionCreatedWithSameEmail() {
        let params = LoginUserParams(email:fakeUser.email!, password:"12345")
        mockAuth.user = fakeUser
        sut.loginUser(params) { (result) in
            switch result {
            case let .success(user):
                XCTAssertTrue(user?.email == params.email)
                break
            case .failure(_):
                break
            }
            self.expectation.fulfill()
        }
        waitForExpectation()
    }
    
}
