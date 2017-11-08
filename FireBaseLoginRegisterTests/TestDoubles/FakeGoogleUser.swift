//
//  StubGoogleUser.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 6/11/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import GoogleSignIn

class FakeGoogleUser: GIDGoogleUser {
    
    override var authentication: GIDAuthentication! {
        return FakeGoogleAuth()
    }
    
    override var profile: GIDProfileData! {
        return FakeGoogleProfile()
    }
    
}

class FakeGoogleAuth: GIDAuthentication {
    
    override var idToken: String! {
        return "Fake ID Token"
    }
    
    override var accessToken: String! {
        return "Fake Access Token"
    }
}

class FakeGoogleProfile: GIDProfileData {
    
    override var email: String! {
        return "Fake email"
    }
    
    override var name: String! {
        return "Fake name"
    }
    
}
