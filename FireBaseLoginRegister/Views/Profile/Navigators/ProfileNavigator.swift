//
//  ProfileNavigator.swift
//  ComparsApp
//
//  Created by Carlos Roig on 4/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

protocol ProfileNavigator {
    func userDidLogOut()
}

extension AppRootNavigator: ProfileNavigator {
    func userDidLogOut() {
        
    }
}
