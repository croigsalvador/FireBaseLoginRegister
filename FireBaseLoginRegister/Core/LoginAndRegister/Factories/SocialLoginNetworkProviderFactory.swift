//
//  SocialUseCaseFactory.swift
//  ComparsApp
//
//  Created by Carlos Roig on 3/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import FacebookLogin
import GoogleSignIn
import UIKit

enum SocialType {
    case facebook
    case google
    case twitter
}

class SocialLoginNetworkProviderFactory {
    
    fileprivate let facebookProvider: SocialLoginNetworkProvider
    fileprivate let googleProvider: SocialLoginNetworkProvider
    
    init(_ facebookProvider:SocialLoginNetworkProvider, _ googleProvider: SocialLoginNetworkProvider) {
        self.facebookProvider = facebookProvider
        self.googleProvider = googleProvider
    }
    
    func connect(_ social: SocialType, _ completion:@escaping (SocialRequestModel?, Error?)->()) {
        switch social {
        case .facebook:
            facebookProvider.connectUser(with: completion)
            break
        case .google:
            googleProvider.connectUser(with: completion)
            break
        case .twitter:
            break
        }
    }
    
    
    
}
