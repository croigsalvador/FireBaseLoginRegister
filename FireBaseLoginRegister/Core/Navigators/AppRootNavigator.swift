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
    let authenticationDependencies: AuthenticationDependencies
    let profileDependencies: ProfileDependencies
    fileprivate let sessionPersistor: UserSessionPersistorProtocol
    
    init(_ authenticationDependencies: AuthenticationDependencies,_ profileDependencies: ProfileDependencies) {
        self.authenticationDependencies = authenticationDependencies
        self.profileDependencies = profileDependencies
        self.sessionPersistor = profileDependencies.sessionPersistor()
        super.init()
        self.authenticationDependencies.navigator = self
        self.profileDependencies.navigator = self
    }
    
    func launchAppFlow() {
        let initialViewController = UINavigationController.init(rootViewController: profileDependencies.profileViewController())
        setupRootViewController(initialViewController,.toBottom)
    }
    
    func installRootViewController(in window:UIWindow) {
        self.window = window
        if isLogged {
            launchAppFlow()
        } else {
            launchMainAuthentincation()
        }
    }
    
    func  launchMainAuthentincation() {
        let initialViewController = UINavigationController.init(rootViewController: authenticationDependencies.mainAuthenticationhViewController())
        setupRootViewController(initialViewController,.toTop)
    }
    
    fileprivate func setupRootViewController(_ viewController: UINavigationController, _ direction: UIWindow.TransitionOptions.Direction) {
        currentNavigationController = viewController
        let transition = UIWindow.TransitionOptions.init(direction:direction, style: .linear)
        window.setRootViewController(viewController, options: transition)
    }
    
    fileprivate var isLogged: Bool {
        return sessionPersistor.getUser() != nil
    }

}


