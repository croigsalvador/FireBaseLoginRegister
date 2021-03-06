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
    fileprivate let persistor: UserSessionPersistorProtocol
    
    init(provider: SessionUserNetworkProvider, persistor: UserSessionPersistorProtocol) {
        self.provider = provider
        self.persistor = persistor
    }
    
    func register(name:String, email: String, password: String, success:@escaping (Bool)->()) {
        let userParams = RegisterUserBasicParams(name,email,password)
        provider.register(userParams) { (result) in
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
