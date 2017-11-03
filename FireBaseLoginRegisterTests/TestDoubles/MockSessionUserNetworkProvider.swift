//
//  MockSessionUserNetworkProvider.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 27/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
@testable import FireBaseLoginRegister

class MockSessionUserNetworkProvider :  SessionUserNetworkProvider {
    
    var error: Error?
    var userSession: UserSession = UserSession.init(id:"123", name: "Test", email: "session@sadasd.com")
    var called = false

    func register(_ registerParams: RegisterUserBasicParams, _ completion: @escaping (RegisterResult) -> ()) {
        result(completion)
    }
    
    func register(_ request: SocialRequestModel, _ completion: @escaping (RegisterResult) -> ()) {
        result(completion)
    }
    
    func loginUser(_ loginParams: LoginUserParams, _ completion: @escaping (RegisterResult) -> ()) {
        result(completion)
    }
    
    private func result(_ completion: @escaping (RegisterResult) -> ()) {
        called = true
        if let error = error {
            completion(RegisterResult.failure(error))
        } else {
            completion(RegisterResult.success(userSession))
        }
    }
}
