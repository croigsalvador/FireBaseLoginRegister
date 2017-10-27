//
//  Dependencies.swift
//  FireBaseLoginRegister
//
//  Created by Carlos Roig on 27/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import UIKit

protocol Depedencies {
    func storyboard(_ name: String) -> UIStoryboard
    func viewController(_ storyBoard:String,_ name:String) -> UIViewController
    func sessionPersistor() -> UserSessionPersistor
}

extension Depedencies {
    func storyboard(_ name: String) -> UIStoryboard {
        return UIStoryboard(name:name, bundle: nil)
        
    }
    func viewController(_ storyboardName:String,_ name:String) -> UIViewController {
        return storyboard(storyboardName).instantiateViewController(withIdentifier:name)
    }
    

    func sessionPersistor() -> UserSessionPersistor {
        return UserSessionPersistor(UserDefaultsStorageCoordinator(UserDefaults.standard, modelKey: "UserSession", serializer:ItemSerializer()))
    }
}
