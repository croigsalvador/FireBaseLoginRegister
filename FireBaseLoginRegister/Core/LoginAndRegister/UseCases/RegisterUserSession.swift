//
//  RegisterUserSession.swift
//  ComparsApp
//
//  Created by Carlos Roig on 8/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

class RegisterUserSession {
    
    fileprivate let provider: SessionUserNetworkProvider
    fileprivate let persistor: UserSessionPersistor
    
    init(provider: SessionUserNetworkProvider, persistor: UserSessionPersistor) {
        self.provider = provider
        self.persistor = persistor
    }
    
    func register(name:String, email: String, password: String, success:@escaping (Bool)->()) {
        provider.register(name: name, email: email, password: password) { (user) in
            guard let user = user else {
                success(false)
                return
            }
            self.persistor.save(user, completion: success)
        }
    }
}
