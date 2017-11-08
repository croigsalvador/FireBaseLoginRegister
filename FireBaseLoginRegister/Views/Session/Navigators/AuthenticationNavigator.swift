//
//  AuthenticationNavigator.swift
//  ComparsApp
//
//  Created by Carlos Roig on 3/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

protocol AuthenticationNavigator {
    func openLogin()
    func openRegister()
    func openApp()
}

extension AppRootNavigator: AuthenticationNavigator {
    func openLogin() {
        currentNavigationController?.pushViewController(authenticationDependencies.loginViewController(), animated:true)
    }
    
    func openRegister() {
        currentNavigationController?.pushViewController(authenticationDependencies.registerViewController(), animated:true)
    }
    
    func openApp() {
        launchAppFlow()
    }
}
