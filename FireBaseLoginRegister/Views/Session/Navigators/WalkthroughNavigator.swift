//
//  WalkthroughNavigator.swift
//  ComparsApp
//
//  Created by Carlos Roig on 3/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

protocol WalkthroughNavigator {
    func openLogin()
    func openRegister()
    func openApp()
}

extension AppRootNavigator: WalkthroughNavigator {
    func openLogin() {
        currentNavigationController?.pushViewController(walkthroughDependencies.loginViewController(), animated:true)
    }
    
    func openRegister() {
        currentNavigationController?.pushViewController(walkthroughDependencies.registerViewController(), animated:true)
    }
    
    func openApp() {
        appRootViewController()
    }
}
