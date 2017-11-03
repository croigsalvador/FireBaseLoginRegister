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
    
    fileprivate let view: UIViewController
    
    init(view: UIViewController) {
        self.view = view
    }
    
    func connect(_ social: SocialType, _ completion:@escaping (SocialRequestModel?, Error?)->()) {
        switch social {
        case .facebook:
            facebookLogin().connectUser(with: completion)
            break
        case .google:
            googleLogin().connectUser(with: completion)
            break
        case .twitter:
            break
        }
    }
    
    private func facebookLogin() -> SocialLoginNetworkProvider {
            return  FacebookLoginNetworkProvider(manager:LoginManager(), view:view)
    }
    
    private func googleLogin() -> SocialLoginNetworkProvider {
       return GoogleLoginNetworkProvider(manager:GIDSignIn.sharedInstance(), view:view)
    }
    
}
