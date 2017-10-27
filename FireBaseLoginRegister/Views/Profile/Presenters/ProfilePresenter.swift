//
//  ProfilePresenter.swift
//  ComparsApp
//
//  Created by Carlos Roig on 4/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

class ProfilePresenter: Presenter {
    
    private let sessionLogOut: SessionUserLogOutUseCase
    private let navigator: ProfileNavigator
    
    
    init(navigator: ProfileNavigator, sessionLogOut: SessionUserLogOutUseCase) {
        self.sessionLogOut = sessionLogOut
        self.navigator = navigator
    }
    
    func logOut() {
        sessionLogOut.logOut()
    }
}
