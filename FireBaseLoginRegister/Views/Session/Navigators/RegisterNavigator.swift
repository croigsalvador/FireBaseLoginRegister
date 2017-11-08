//
//  RegisterNavigator.swift
//  ComparsApp
//
//  Created by Carlos Roig on 9/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

protocol RegisterNavigator {
    func openMainApp()
}

extension AppRootNavigator: RegisterNavigator {
    func openMainApp() {
        launchAppFlow()
    }
}
