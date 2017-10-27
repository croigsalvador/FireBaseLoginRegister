//
//  GoogleLogoutNetworkProvider.swift
//  ComparsApp
//
//  Created by Carlos Roig on 5/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import GoogleSignIn

class GoogleLogoutNetworkProvider: SocialLogoutProvider {
    
    fileprivate let manager: GIDSignIn
    
    init(manager: GIDSignIn) {
        self.manager = manager
    }
    
    func logOut() {
        manager.signOut()
    }
}
