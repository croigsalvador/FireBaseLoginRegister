//
//  AppRootNavigator.swift
//  ComparsApp
//
//  Created by Carlos Roig on 4/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import UIKit

class AppRootNavigator: RootNavigator {
    
    var window: UIWindow!
    let walkthroughDependencies: WalkthroughDependencies
    let profileDependencies: ProfileDependencies
    fileprivate let sessionPersistor: UserSessionPersistor
    
    init(_ walkthroughDependencies: WalkthroughDependencies,_ profileDependencies: ProfileDependencies, sessionPersistor:UserSessionPersistor) {
        self.walkthroughDependencies = walkthroughDependencies
        self.profileDependencies = profileDependencies
        self.sessionPersistor = sessionPersistor
        super.init()
        self.walkthroughDependencies.navigator = self
        self.profileDependencies.navigator = self
    }
    
    func appRootViewController() {
        let initialViewController = UINavigationController.init(rootViewController: profileDependencies.profileViewController())
        setupRootViewController(initialViewController)
    }
    
    func installRootViewController(in window:UIWindow) {
        self.window = window
        if isLogged {
            appRootViewController()
        } else {
            walkthroughViewController()
        }
    }
    
    func  walkthroughViewController() {
        let initialViewController = UINavigationController.init(rootViewController: walkthroughDependencies.walkThroughViewController())
        setupRootViewController(initialViewController)
    }
    
    fileprivate func setupRootViewController(_ viewController: UINavigationController) {
        currentNavigationController = viewController
        window.rootViewController = viewController
    }
    
    fileprivate var isLogged: Bool {
        return sessionPersistor.getUser() != nil
    }

}


