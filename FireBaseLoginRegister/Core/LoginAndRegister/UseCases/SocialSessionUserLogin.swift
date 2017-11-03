//
//  GoogleConnect.swift
//  ComparsApp
//
//  Created by Carlos Roig on 3/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import UIKit

class SocialSessionUserLogin: SocialSessionUserLoginUseCase {
    
    fileprivate let socialProviderFactory: SocialLoginNetworkProviderFactory
    fileprivate let sessionProvider: SessionUserNetworkProvider
    fileprivate let sessionPersistor: UserSessionPersistorProtocol
    internal var notificationCenter: NotificationCenter?
    
    init(notificationCenter: NotificationCenter, socialProviderFactory:SocialLoginNetworkProviderFactory, sessionProvider: SessionUserNetworkProvider, sessionPersistor: UserSessionPersistorProtocol) {
        self.notificationCenter = notificationCenter
        self.socialProviderFactory = socialProviderFactory
        self.sessionProvider = sessionProvider
        self.sessionPersistor = sessionPersistor
    }
    
    func connect(_ social: SocialType,_ success:@escaping (Bool)->()) {
        socialProviderFactory.connect(social) { (request, error) in
            guard let request = request else {
                success(false)
                return
            }
            self.sessionProvider.register(request, { (result) in
                switch result {
                case let .success(userSession):
                   self.saveData(userSession, success)
                case .failure(_):
                    success(false)
                }
            })
            
        }
    }
    
    private func saveData(_ user: UserSession?, _ success:@escaping (Bool)->())  {
        guard let user = user else {
            success(false)
            return
        }
        self.sessionPersistor.save(user, completion: { (fail) in
            DispatchQueue.main.async {
                if !fail {
                    self.userDidLogin(user)
                }
                success(fail)
            }
        })
        return
    }
}
