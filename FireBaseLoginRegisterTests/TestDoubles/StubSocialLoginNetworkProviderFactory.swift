//
//  StubSocialLoginNetworkProviderFactory.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 27/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
@testable import FireBaseLoginRegister

class StubSocialLoginNetworkProviderFactory: SocialLoginNetworkProviderFactory {

    var error: Error?
    var connectCalled = true
    var request: SocialRequestModel = RequestSocialRequestModel.init(idToken: nil, token: "TOKEN 123", name: "AASD ASD", email: "fake@gmail.com", loginType:UserSessionType.facebook)
    var completionHandler : (SocialRequestModel?, Error?) -> Void? = {(request, error) in ()}
    
    override func connect(_ social: SocialType, _ completion: @escaping (SocialRequestModel?, Error?) -> ()) {
        completionHandler = completion
        connectCalled = true
        if let error = error {
            completionHandler(nil,error)
        } else {
            completionHandler(request,nil)
        }
    }
    
}
