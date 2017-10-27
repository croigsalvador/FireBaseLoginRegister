//
//  FacebookLogoutNetworkProvider.swift
//  ComparsApp
//
//  Created by Carlos Roig on 4/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import FacebookLogin

protocol SocialLogoutProvider {
    func logOut()
}

class FacebookLogoutNetworkProvider: SocialLogoutProvider {
    
    fileprivate let manager: LoginManager
    
    init(manager: LoginManager) {
        self.manager = manager
    }
    
    func logOut() {
        manager.logOut()
    }
}

