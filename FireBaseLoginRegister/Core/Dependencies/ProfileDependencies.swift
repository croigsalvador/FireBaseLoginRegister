//
//  ProfileDependencies.swift
//  FireBaseLoginRegister
//
//  Created by Carlos Roig on 4/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import UIKit
import FacebookLogin
import GoogleSignIn
import Firebase

class ProfileDependencies: Depedencies {

    var navigator: AppRootNavigator!
    
    func profileViewController() -> ProfileViewController {
        let walkViewController = viewController(for: "ProfileViewController") as! ProfileViewController
        let presenter = ProfilePresenter.init(navigator:navigator, sessionLogOut:sessionUserLogOut())
        walkViewController.presenter = presenter
        
        return walkViewController
    }
    
    private func sessionUserLogOut() -> SessionUserLogOutUseCase {
        let sessionLogout = SessionUserLogOut.init(notificationCenter: NotificationCenter.default, networkFactory: SocialLogOutNetworProviderkFactory(fbProvider: FacebookLogoutNetworkProvider(manager: LoginManager()),googleProvider:GoogleLogoutNetworkProvider(manager: GIDSignIn.sharedInstance())),sessionPersistor:sessionPersistor(), sessionProvider:SessionLogoutNetworkProvider.init(auth: Auth.auth()))
        return sessionLogout
    }
    
    private func viewController(for name:String) -> UIViewController {
        return viewController("Profile", name)
    }

}
