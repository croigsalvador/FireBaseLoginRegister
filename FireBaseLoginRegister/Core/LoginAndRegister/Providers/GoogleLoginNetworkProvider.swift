//
//  GoogleLoginNetworkProvider.swift
//  ComparsApp
//
//  Created by Carlos Roig on 5/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn

class GoogleLoginNetworkProvider: NSObject, SocialLoginNetworkProvider, GIDSignInDelegate, GIDSignInUIDelegate {
    
    var view: UIViewController!
    fileprivate let manager: GIDSignIn
    internal var completionHandler : (UserSession?, Error?) -> Void? = {(user, error) in ()}
    
    init(manager: GIDSignIn, view:UIViewController) {
        self.manager = manager
        self.view = view
    }
    
    func connectUser(with completion: @escaping (UserSession?, Error?) -> ()) {
        manager.clientID = FirebaseApp.app()?.options.clientID
        manager.delegate = self
        manager.uiDelegate = self
        completionHandler = completion
        manager.scopes = ["https://www.googleapis.com/auth/plus.login",
                          "https://www.googleapis.com/auth/userinfo.email"]
        manager.signIn()
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        if let error = error {
            completionHandler(nil,error)
            return
        }
        
        completionHandler(parse(user), nil)
        
    }
    
    func parse(_ googleUser: GIDGoogleUser) -> UserSession? {
        guard let authentication = googleUser.authentication else { return nil }
        let userDict = ["id": googleUser.userID,
                        "token": googleUser.authentication.accessToken,
                        "idToken":authentication.idToken,
                        "name": googleUser.profile.name,
                        "email": googleUser.profile.email,
                        "loginType": UserSessionType.google.rawValue]
        return UserSession.init(dictionary: userDict as [String : AnyObject])
        
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        view.present(viewController, animated: true) { }
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        view.dismiss(animated: true) {}
    }
    
    var isLogged: Bool {
        return false
    }
}
