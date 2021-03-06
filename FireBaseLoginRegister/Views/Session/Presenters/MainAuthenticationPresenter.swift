//
//  WalkThroughPresenter.swift
//  ComparsApp
//
//  Created by Carlos Roig on 3/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import UIKit

class MainAuthenticationPresenter: Presenter {
    
    fileprivate let navigator: AuthenticationNavigator
    fileprivate let socialSession: SocialSessionUserLoginUseCase
    
    init(navigator: AuthenticationNavigator, socialSession: SocialSessionUserLoginUseCase) {
        self.navigator = navigator
        self.socialSession = socialSession
    }
    
    func facebook() {
        socialLogin(social:.facebook)
    }
    
    func google(){
        socialLogin(social:.google)
    }
    
    func login() {
        navigator.openLogin()
    }
    
    func register () {
        navigator.openRegister()
    }
    
    private func socialLogin(social:SocialType) {
        socialSession.connect(social) { (success) in
            DispatchQueue.main.async {
                if success {
                    self.navigator.openApp()
                }
            }
        }
        
    }
    
}
