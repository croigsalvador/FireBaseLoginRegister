//
//  SessionLogoutNetworkProvider.swift
//  FireBaseLoginRegister
//
//  Created by Carlos Roig on 3/11/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import Firebase

class SessionLogoutNetworkProvider {
    
    fileprivate let auth: Auth
    
    init(auth: Auth) {
        self.auth = auth
    }
    
    func logOut() {
        guard let _ = try? auth.signOut() else {
            return
        }
        
    }
}
