//
//  RegisterSocialRequestModel.swift
//  FireBaseLoginRegister
//
//  Created by Carlos Roig on 3/11/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

protocol SocialRequestModel {
    var idToken: String? { get }
    var token: String { get }
    var name: String { get }
    var email: String { get }
    var loginType: UserSessionType { get }
}

struct RequestSocialRequestModel: SocialRequestModel {
    let idToken: String?
    let token: String
    let name: String
    let email: String
    let loginType: UserSessionType
}
