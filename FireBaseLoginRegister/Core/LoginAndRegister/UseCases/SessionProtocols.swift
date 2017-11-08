//
//  UserSessionSocialLoginUseCase.swift
//  ComparsApp
//
//  Created by Carlos Roig on 5/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

protocol SocialSessionUserLoginUseCase {
    var notificationCenter: NotificationCenter? {get}
    func connect(_ social: SocialType,_ success:@escaping (Bool)->()) 
}

extension SocialSessionUserLoginUseCase {
    func userDidLogin(_ user:UserSession){
        notificationCenter?.post(name:.UserDidLoginNotification, object: nil, userInfo: ["UserSession":user])
    }
}

protocol SessionUserLogOutUseCase {
    var notificationCenter: NotificationCenter? {get}
    func logOut()
}

extension SessionUserLogOutUseCase {
    func userDidLogout(_ user: UserSession){
        notificationCenter?.post(name:.UserDidLogoutNotification, object: nil, userInfo: ["UserSession":user])
    }
}
