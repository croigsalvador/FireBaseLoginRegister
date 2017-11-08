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
    fileprivate let persistor: UserSessionPersistorProtocol
    
    init(provider: SessionUserNetworkProvider, persistor: UserSessionPersistorProtocol) {
        self.provider = provider
        self.persistor = persistor
    }
    
    func login(email: String, password: String, success:@escaping (Bool)->()) {
        let params = LoginUserParams(email:email, password:password)
        provider.loginUser(params) { (result) in
            switch result {
            case let .success(userSession):
                guard let user = userSession else {
                    success(false)
                    return
                }
                self.persistor.save(user, completion: success)
            case .failure(_):
                success(false)
            }
        }
    }
    
}
