//
//  FacebookConnectNetworkProvider.swift
//  ComparsApp
//
//  Created by Carlos Roig on 3/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

import UIKit
import FacebookLogin
import FacebookCore

class FacebookLoginNetworkProvider: SocialLoginNetworkProvider{
    
    var view: UIViewController!
    fileprivate let loginManager: LoginManager
    fileprivate let graphConnection = GraphRequestConnection()
    internal var completionHandler : (SocialRequestModel?, Error?) -> Void? = {(request, error) in ()}

    
    init(manager: LoginManager, view:UIViewController) {
        self.loginManager = manager
        self.view = view
    }
    
    func connectUser(with completion: @escaping (SocialRequestModel?, Error?) -> ()) {
        loginManager.logIn(readPermissions: [ReadPermission.publicProfile, ReadPermission.email], viewController: view) { (loginResult) in
            switch loginResult {
            case .failed(let error):
                completion(nil, error)
                break
            case .cancelled:
                completion(nil,nil)
                break
            case .success(_, _, let accessToken):
                self.graphConnection.add(MyProfileRequest()) { response, result in
                    switch result {
                    case .success(let response):
                        guard let dictionary = response.dictionary as? [String:AnyObject] else {
                            completion(nil,nil)
                            return
                        }
                        let request = RequestSocialRequestModel.init(idToken: nil, token: accessToken.authenticationToken, name: dictionary["name"] as! String, email: dictionary["email"] as! String, loginType: UserSessionType.facebook)
                        completion(request,nil)                        
                    case .failed(let error):
                        completion(nil,error)
                    }
                }
                self.graphConnection.start()
                break
            }
        
        }
    }
    
    var isLogged: Bool {
        return AccessToken.current != nil
    }
}

struct MyProfileRequest: GraphRequestProtocol {
    struct Response: GraphResponseProtocol {
        var dictionary : Any?
        init(rawResponse: Any?) {
            dictionary = rawResponse
        }
    }
    var graphPath = "/me"
    var parameters: [String : Any]? = ["fields": "id, name, email"]
    var accessToken = AccessToken.current
    var httpMethod: GraphRequestHTTPMethod = .GET
    var apiVersion: GraphAPIVersion = .defaultVersion
}
