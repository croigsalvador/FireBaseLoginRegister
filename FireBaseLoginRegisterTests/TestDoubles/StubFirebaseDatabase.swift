//
//  StubFirebaseDatabase.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 3/11/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import FirebaseDatabase

class StubFirebaseDatabase: Database {
    
    override class func database() -> StubFirebaseDatabase {
        return StubFirebaseDatabase()
    }
}
