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
    fileprivate let sessionPersistor: UserSessionPersistor
    internal var notificationCenter: NotificationCenter?
    
    init(notificationCenter: NotificationCenter, socialProviderFactory:SocialLoginNetworkProviderFactory, sessionProvider: SessionUserNetworkProvider, sessionPersistor: UserSessionPersistor) {
        self.notificationCenter = notificationCenter
        self.socialProviderFactory = socialProviderFactory
        self.sessionProvider = sessionProvider
        self.sessionPersistor = sessionPersistor
    }
    
    func connect(_ social: SocialType, with completion:@escaping (Bool)->()) {
        socialProviderFactory.connect(social) { (user, error) in
            guard let user = user else {
                completion(false)
                return
            }
            self.sessionProvider.register(userSession: user, with: { (user) in
                guard let user = user else {
                    return
                }
                self.sessionPersistor.save(user, completion: { (success) in
                    DispatchQueue.main.async {
                        if success {
                            self.userDidLogin(user)
                        }
                        completion(success)
                    }
                })
                return
                
            })
            
        }
    }
}
