//
//  MockGoogleSignIn.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 6/11/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import GoogleSignIn

class MockGoogleSignIn: GIDSignIn {
    
    var error: Error?
    var googleUser: GIDGoogleUser?
        
    override func signIn() {
        uiDelegate.sign!(self, present: MockViewController())
        delegate.sign(self, didSignInFor:googleUser , withError: error)
    }
    
    
    
}

