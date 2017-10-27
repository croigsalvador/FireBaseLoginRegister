//
//  EmailLoginUser.swift
//  ComparsApp
//
//  Created by Carlos Roig on 29/9/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

class LoginUserSession {
    
    fileprivate let provider: SessionUserNetworkProvider
    fileprivate let persistor: UserSessionPersistor
    
    init(provider: SessionUserNetworkProvider, persistor: UserSessionPersistor) {
        self.provider = provider
        self.persistor = persistor
    }
    
    func login(email: String, password: String, success:@escaping (Bool)->()) {
        provider.loginUser(with: email, password: password) { (user) in
            guard let user = user else {
                success(false)
                return
            }
            self.persistor.save(user, completion: success)
        }
    }

}
