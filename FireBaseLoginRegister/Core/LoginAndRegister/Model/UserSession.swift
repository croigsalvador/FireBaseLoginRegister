//
//  UserSession.swift
//  ComparsApp
//
//  Created by Carlos Roig on 4/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

enum UserSessionType: String {
    case mail = "mail"
    case facebook = "facebook"
    case google = "google"
    case twitter = "twitter"
}

struct UserSession {
    var id: String?
    let token: String?
    let idToken: String?
    let name: String
    let email: String
    let loginType: String
    
    init() {
        self.id = ""
        self.token = ""
        self.email = ""
        self.name = ""
        self.idToken = ""
        self.loginType = UserSessionType.mail.rawValue
    }
    
    init(dictionary: [String:AnyObject]) {
        self.id = dictionary[UserSession.kPropertyUserSessionId] as? String
        self.token = dictionary[UserSession.kPropertyUserSessionToken] as? String
        self.idToken = dictionary[UserSession.kPropertyUserSessionIdToken] as? String
        self.name = dictionary[UserSession.kPropertyUserSessionName] as! String
        self.email = dictionary[UserSession.kPropertyUserSessionEmail] as! String
        self.loginType = dictionary[UserSession.kPropertyUserSessionType] as! String
    }
}

extension UserSession {
    init(id: String, name: String, email:String) {
        self.id = id
        self.email = email
        self.name = name
        self.loginType = UserSessionType.mail.rawValue
        self.token = nil
        self.idToken = nil
    }
}

extension UserSession : Serializable {
    static let kPropertyUserSessionId = "id"
    static let kPropertyUserSessionToken = "token"
    static let kPropertyUserSessionIdToken = "idToken"
    static let kPropertyUserSessionName = "name"
    static let kPropertyUserSessionEmail = "email"
    static let kPropertyUserSessionType = "loginType"
    
    func serialize() -> [String : AnyObject] {
        return [UserSession.kPropertyUserSessionId:self.id.nilToEmpty() as AnyObject,
                UserSession.kPropertyUserSessionToken:self.token.nilToEmpty() as AnyObject,
                UserSession.kPropertyUserSessionIdToken:self.idToken.nilToEmpty() as AnyObject,
                UserSession.kPropertyUserSessionName:self.name as AnyObject,
                UserSession.kPropertyUserSessionEmail:self.email as AnyObject,
                UserSession.kPropertyUserSessionType:self.loginType as AnyObject]
    }
    
    init?(byDeserializing dictionary: [String : AnyObject]) {
        self.init(dictionary: dictionary)
    }
}
