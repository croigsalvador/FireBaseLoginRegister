//
//  SessionUserNetworkProvider.swift
//  ComparsApp
//
//  Created by Carlos Roig on 29/9/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class SessionUserNetworkProvider {
    
    fileprivate let firebase: DatabaseReference = Database.database().reference(withPath: "users")
    fileprivate let auth = Auth.auth()
    
    func register(name:String, email: String, password:String, completion:@escaping (UserSession?)->())  {
        auth.createUser(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                completion(nil)
                return
            }
            let userSession = UserSession(id: user.uid, name: name, email: email)
            self.save(userSession, completion: completion)
        }
    }
    
    func loginUser(with email: String, password: String, completion:@escaping (UserSession?)->())  {
        auth.signIn(withEmail: email, password: password) { (user, error) in
            guard let user = user else {
                completion(nil)
                return
            }
            completion(UserSession(id: user.uid, name: "", email: email))
        }
    }
    
    func current() -> UserSession? {
        if auth.currentUser != nil {
            return UserSession()
        }
        return nil
    }
    
    func register(userSession:UserSession, with success:@escaping (UserSession?)->()) {
        var credential = FacebookAuthProvider.credential(withAccessToken:userSession.token!)
        if userSession.loginType == UserSessionType.google.rawValue {
            credential = GoogleAuthProvider.credential(withIDToken: userSession.idToken!,
                                                       accessToken: userSession.token!)
        }
        
        auth.signIn(with: credential) { (user, error) in
            print(error?.localizedDescription ?? "No value")
            guard let fUser = user else {
                success(nil)
                return
            }
            var userDict =  userSession.serialize()
            userDict["id"] = fUser.uid as AnyObject
            let updatedUser = UserSession.init(dictionary: userDict)
            self.save(updatedUser, completion:success)
        }
    }
    
    fileprivate func save(_ user: UserSession, completion:@escaping (UserSession?)->()) {
        guard let id = user.id else {
            completion(nil)
            return
        }
        let child = self.firebase.child(id)
        let values = ["name": user.name, "email": user.email]
        child.updateChildValues(values, withCompletionBlock: { (error, reference) in
            guard let _ = error else {
                completion(user)
                return
            }
            completion(nil)
        })
    }
    
}

class SessionLogoutNetworkProvider {
    
    fileprivate let auth = Auth.auth()
    
    func logOut() {
        guard let _ = try? auth.signOut() else {
            return
        }
        
    }
    
}
