//
//  SocialNetworkProvider.swift
//  ComparsApp
//
//  Created by Carlos Roig on 5/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import UIKit

protocol SocialLoginNetworkProvider {
    var isLogged : Bool{get}
    var view: UIViewController! {get set}
    var completionHandler : (SocialRequestModel?, Error?) -> Void?  {get set}
    func connectUser(with completion: @escaping (SocialRequestModel?, Error?) -> ())
}

