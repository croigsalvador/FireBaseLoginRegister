//
//  StubSocialLoginNetworkProviderFactory.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 27/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
@testable import FireBaseLoginRegister

class StubSocialLoginNetworkProviderFactory: SocialLoginNetworkProviderFactory {

    var error: Error?
    var connectCalled = true
    var userSession: UserSession = UserSession.init(id:"123", name: "Test", email: "session@sadasd.com")
    
    override func connect(_ social: SocialType, _ completion: @escaping (UserSession?, Error?) -> ()) {
        connectCalled = true
        if let error = error {
            completion(nil,error)
        } else {
            completion(userSession,nil)
        }
    }
    
}
