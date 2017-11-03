//
//  MokUserSessionPersistor.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 27/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
@testable import FireBaseLoginRegister

class MockUserSessionPersistor: UserSessionPersistorProtocol {
    var saveCalled = false
    var removeCalled = false
    var getUserCalled = false

    var success = false
    
    func save(_ user: UserSession, completion: @escaping (Bool) -> Void) {
        saveCalled = true
        completion(success)
    }
    
    func removeUser() {
        removeCalled = true
    }
    
    func getUser() -> UserSession? {
        getUserCalled = true
        return nil
    }
    
    
}
