//
//  SessionUserLogOut.swift
//  ComparsApp
//
//  Created by Carlos Roig on 4/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import FacebookLogin


class SessionUserLogOut: SessionUserLogOutUseCase {
    
    private let networkFactory: SocialLogOutNetworProviderkFactory
    private let sessionPersistor: UserSessionPersistorProtocol
    internal var notificationCenter: NotificationCenter?
    private let sessionProvider: SessionLogoutNetworkProvider
    
    init(notificationCenter:NotificationCenter, networkFactory: SocialLogOutNetworProviderkFactory, sessionPersistor: UserSessionPersistorProtocol, sessionProvider: SessionLogoutNetworkProvider) {
        self.networkFactory = networkFactory
        self.sessionPersistor = sessionPersistor
        self.notificationCenter = notificationCenter
        self.sessionProvider = sessionProvider
    }
    
    func logOut() {
        networkFactory.logOut(user:sessionPersistor.getUser()!)
        sessionProvider.logOut()
        userDidLogout(sessionPersistor.getUser()!)
        sessionPersistor.removeUser()
    }
}

        
