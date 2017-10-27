//
//  ProfileRootNavigator.swift
//  ComparsApp
//
//  Created by Carlos Roig on 4/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import UIKit

class ProfileRootNavigator: TabNavigator {
    
    let dependencies: ProfileDependencies
    
    init(_ dependencies: ProfileDependencies) {
        self.dependencies = dependencies
        super.init()
        self.dependencies.navigator = self
    }
    
    override func start() {
        let vc = dependencies.profileViewController()
        vc.title = "Perfil"
        currentNavigationController = UINavigationController(rootViewController:vc)
    }
}
