//
//  StubSocialSessionUserLoginUseCase.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 27/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import XCTest
@testable import FireBaseLoginRegister


class StubSocialSessionUserLoginUseCase: SocialSessionUserLoginUseCase {
    
    var notificationCenter: NotificationCenter?
    var success = true
    var connectCalled = false
    
    func connect(_ social: SocialType, _ completion: @escaping (Bool) -> ()) {
        connectCalled = true
        completion(success)
    }
    
}
