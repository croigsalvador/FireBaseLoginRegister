//
//  StubWalkthroughNavigator.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 27/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import XCTest
@testable import FireBaseLoginRegister

class StubWalkthroughNavigator: AuthenticationNavigator {
    
    var didOpenLogin = false
    var didOpenRegister = false
    var didOpenApp = false
    
    
    func openLogin() {
        didOpenLogin = true
    }
    
    func openRegister() {
        didOpenRegister = true
    }
    
    func openApp() {
        didOpenApp = true
    
    }
    
}
