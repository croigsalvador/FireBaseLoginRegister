//
//  MockFirebaseDatabase.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 6/11/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import FirebaseDatabase

class MockFirebaseDatabase: Database {
    
    var stubReference: DatabaseReference!
    
    override func reference() -> DatabaseReference {
        return stubReference
    }
    
    override func reference(withPath path: String) -> DatabaseReference {
        return stubReference
    }
}

class StubFirebaseDatabaseReference : DatabaseReference {
    
    var error: Error?
    override func updateChildValues(_ values: [AnyHashable : Any], withCompletionBlock block: @escaping (Error?, DatabaseReference) -> Void) {
        block(error,self)
    }
    
    override func child(_ pathString: String) -> DatabaseReference {
        return self
    }
    
}
