//
//  ProfileDependencies.swift
//  FireBaseLoginRegister
//
//  Created by Carlos Roig on 4/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth
import FacebookLogin
import GoogleSignIn

class ProfileDependencies {

    var navigator: ProfileRootNavigator!
    
    func profileViewController() -> ProfileViewController {
        let walkViewController = viewController(for: "ProfileViewController") as! ProfileViewController
        let presenter = ProfilePresenter.init(navigator:navigator, sessionLogOut:sessionUserLogOut())
        walkViewController.presenter = presenter
        
        return walkViewController
    }
    
    private func sessionUserLogOut() -> SessionUserLogOutUseCase {
        let sessionPersistor = UserSessionPersistor(UserDefaultsStorageCoordinator(UserDefaults.standard, modelKey: "UserSession", serializer:ItemSerializer()))
        let sessionLogout = SessionUserLogOut.init(notificationCenter: NotificationCenter.default, networkFactory: SocialLogOutNetworProviderkFactory(fbProvider: FacebookLogoutNetworkProvider(manager: LoginManager()),googleProvider:GoogleLogoutNetworkProvider(manager: GIDSignIn.sharedInstance())),sessionPersistor:sessionPersistor, sessionProvider:SessionLogoutNetworkProvider())
        return sessionLogout
    }
    

    
    private func viewController(for name:String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier:name)
    }
    
    private func fireBase() -> DatabaseReference {
        return Database.database().reference(withPath: "users")
    }

}
