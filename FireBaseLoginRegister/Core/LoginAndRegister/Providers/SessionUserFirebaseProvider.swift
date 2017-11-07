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

struct SessionUserFirebaseProvider : SessionUserNetworkProvider{
    
    fileprivate let auth: Auth
    fileprivate let database: Database
    
    init(_ database: Database,_ auth: Auth ) {
        self.database = database
        self.auth = auth
    }
    
    func register(_ registerParams: RegisterUserBasicParams,_ completion: @escaping (RegisterResult) -> ()) {
        auth.createUser(withEmail: registerParams.email, password: registerParams.password) { (user, error) in
            guard let user = user else {
                let result = RegisterResult.failure(error!)
                completion(result)
                return
            }
            let userSession = UserSession(id: user.uid, name:registerParams.name, email:registerParams.email)
            self.save(userSession, completion: completion)
        }
    }
    
    func loginUser(_ loginParams: LoginUserParams, _ completion: @escaping (RegisterResult) -> ()) {
        auth.signIn(withEmail: loginParams.email, password: loginParams.password) { (user, error) in
            guard let user = user else {
                completion(RegisterResult.failure(error!))
                return
            }
            completion(RegisterResult.success(UserSession(id: user.uid, email: loginParams.email)))
        }
    }
    
    func register(_ request: SocialRequestModel, _ completion: @escaping (RegisterResult) -> ()) {
        var credential = FacebookAuthProvider.credential(withAccessToken:request.token)
        if request.loginType == UserSessionType.google {
            credential = GoogleAuthProvider.credential(withIDToken: request.idToken!,
                                                       accessToken: request.token)
        }
        
        register(credential, request, completion)
    }
    
    fileprivate func register(_ credential: AuthCredential, _ request: SocialRequestModel, _ completion: @escaping (RegisterResult) -> ()) {
        auth.signIn(with: credential) { (user, error) in
            print(error?.localizedDescription ?? "No value")
            guard let fUser = user else {
                if let error = error {
                    completion(RegisterResult.failure(error))
                }
                return
            }
            
            var updatedUser = UserSession(request)
            updatedUser.id = fUser.uid
            self.save(updatedUser, completion:completion)
        }
    }
    
    private func save(_ user: UserSession, completion: @escaping (RegisterResult) -> ()) {
        guard let id = user.id else {
            return
        }
        let usersReference = database.reference(withPath: "users")
        let child = usersReference.child(id)
        let values = ["name": user.name, "email": user.email]
        child.updateChildValues(values, withCompletionBlock: { (error, reference) in
            guard let error = error else {
                completion(RegisterResult.success(user))
                return
            }
            completion(RegisterResult.failure(error))
        })
    }
}

