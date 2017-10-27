//
//  SessionUserLogOutNetworkFactory.swift
//  ComparsApp
//
//  Created by Carlos Roig on 4/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

class SocialLogOutNetworProviderkFactory {
    
    private let fbProvider : SocialLogoutProvider
    private let googleProvider : SocialLogoutProvider

    init(fbProvider: FacebookLogoutNetworkProvider,googleProvider: SocialLogoutProvider) {
        self.fbProvider = fbProvider
        self.googleProvider = googleProvider
    }
    
    func logOut(user: UserSession) {
        switch user.loginType {
        case UserSessionType.facebook.rawValue:
            fbProvider.logOut()
            break
        case UserSessionType.google.rawValue:
            googleProvider.logOut()
            break
        case UserSessionType.twitter.rawValue:
            break
        case UserSessionType.mail.rawValue:
            break
        default:
            break
        }
    }
}
