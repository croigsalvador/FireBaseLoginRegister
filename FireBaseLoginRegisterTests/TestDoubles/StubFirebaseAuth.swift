//
//  StubFirebaseAuth.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 3/11/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase

class StubFirebaseAuth: Auth {
    
    override class func auth() -> StubFirebaseAuth {
        FirebaseApp.configure()
        return Auth.auth() as! StubFirebaseAuth
    }
}
