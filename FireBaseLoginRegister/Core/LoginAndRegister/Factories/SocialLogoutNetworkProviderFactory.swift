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
        case "facebook":
            fbProvider.logOut()
            break
        case "google":
            googleProvider.logOut()
            break
        case "twitter":
            break
        case "mail":
            break
        default:
            break
        }
    }
}
