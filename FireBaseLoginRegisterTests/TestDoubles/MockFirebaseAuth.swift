//
//  MockFirebaseAuth.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 6/11/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class MockFirebaseAuth: Auth {
 
    var error: Error?
    var user: User?
    
    override class func auth() -> MockFirebaseAuth {
        FirebaseApp.configure()
        return MockFirebaseAuth()
    }
    
    override func createUser(withEmail email: String, password: String, completion: AuthResultCallback? = nil) {
        completion!(user, error)
    }
    
    deinit {
        FirebaseApp.app()?.delete({ (success) in
        
        })
    }
    
}

class FakeFirebaseUser: User {
    override var uid: String {
        return "Fake uid"
    }
    
    override var email: String? {
        return "fake@email.com"
    }
}

