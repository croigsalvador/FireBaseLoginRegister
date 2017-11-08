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
    internal var completionHandler : (SocialRequestModel?, Error?) -> Void? = {(request, error) in ()}
    
    init(manager: GIDSignIn, view:UIViewController) {
        self.manager = manager
        self.view = view
    }
    
    func connectUser(with completion: @escaping (SocialRequestModel?, Error?) -> ()) {
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
        guard let user = user else {
            completionHandler(nil, nil)
            return
        }
        completionHandler(parse(user), nil)
    }
    
    func parse(_ googleUser: GIDGoogleUser) -> SocialRequestModel? {
        guard let authentication = googleUser.authentication else { return nil }
        let request = RequestSocialRequestModel(idToken: authentication.idToken, token: googleUser.authentication.accessToken, name: googleUser.profile.name, email: googleUser.profile.email, loginType: UserSessionType.google)
        
        return request
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        view.present(viewController, animated: true) { }
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        view.dismiss(animated: true) {}
    }
    
    var isLogged: Bool {
        return manager.currentUser != nil
    }
}
