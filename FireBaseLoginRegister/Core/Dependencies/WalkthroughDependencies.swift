//
//  WalkthroughDependencies.swift
//  FireBaseLoginRegister
//
//  Created by Carlos Roig on 3/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import Firebase

class WalkthroughDependencies : Depedencies {
    
    var navigator: AppRootNavigator!
    
    func walkThroughViewController() -> WalkthroughViewController {
        let walkViewController = viewController(for: "WalkthroughViewController") as! WalkthroughViewController
        let presenter = WalkThroughPresenter(navigator:navigator, socialSession:socialSession(view:walkViewController))
        walkViewController.presenter = presenter
        
        return walkViewController
    }
    
    func registerViewController() -> RegisterViewController {
        let registerViewController = viewController(for: "RegisterViewController") as! RegisterViewController
        let presenter = RegisterPresenter(navigator: navigator, registerSession: RegisterUserSession(provider: sessionUserProvider(), persistor:sessionPersistor()))
        presenter.view = registerViewController
        registerViewController.presenter = presenter
        
        return registerViewController
    }
    
    func loginViewController() -> LoginViewController {
        let loginViewController = viewController(for: "LoginViewController") as! LoginViewController
        let presenter = LoginPresenter(navigator: navigator, loginSession: LoginUserSession(provider: sessionUserProvider(), persistor:sessionPersistor()))
        presenter.view = loginViewController
        loginViewController.presenter = presenter
        return loginViewController
    }
    
    private func socialSession(view: UIViewController) -> SocialSessionUserLoginUseCase {
        return SocialSessionUserLogin(notificationCenter: NotificationCenter.default, socialProviderFactory:SocialLoginNetworkProviderFactory(view: view), sessionProvider:sessionUserProvider(), sessionPersistor:sessionPersistor())
    }
    
    private func viewController(for name:String) -> UIViewController {
        return viewController("Session", name)
    }
    
    private func sessionUserProvider() -> SessionUserNetworkProvider {
        return SessionUserNetworkProvider.init(Database.database(), Auth.auth())
    }
}
