//
//  SessionUserNetworkProvider.swift
//  FireBaseLoginRegister
//
//  Created by Carlos Roig on 3/11/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

typealias RegisterResult = Result<UserSession, Error>

protocol SessionUserNetworkProvider {
    func register(_ registerParams: RegisterUserBasicParams, _ completion:@escaping (RegisterResult) -> Void)
    func register(_ request:SocialRequestModel, _ completion:@escaping (RegisterResult) -> Void)
    func loginUser(_ loginParams:LoginUserParams, _ completion:@escaping (RegisterResult) -> Void)
}

