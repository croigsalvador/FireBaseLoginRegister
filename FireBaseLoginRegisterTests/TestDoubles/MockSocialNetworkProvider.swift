//
//  MockSocialNetworkProvider.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 3/11/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import UIKit

@testable import FireBaseLoginRegister

class MockSocialNetworkProvider: SocialLoginNetworkProvider {
    
    var view: UIViewController! = UIViewController()
    var isLogged: Bool = false
    var completionHandler: (SocialRequestModel?, Error?) -> Void? = {(request, error) in ()}
    var request: SocialRequestModel = RequestSocialRequestModel.init(idToken: nil, token: "TOKEN 123", name: "AASD ASD", email: "fake@gmail.com", loginType:UserSessionType.facebook)
    var error: Error?
    var connectCalled = false
    var isFacebook = true
    
    func connectUser(with completion: @escaping (SocialRequestModel?, Error?) -> ()) {
        completionHandler = completion
        connectCalled = true
        if let error = error {
            completionHandler(nil,error)
        } else {
            completionHandler(request,nil)
        }
    }
    
}
