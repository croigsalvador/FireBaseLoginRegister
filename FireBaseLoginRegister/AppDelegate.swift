//
//  AppDelegate.swift
//  FireBaseLoginRegister
//
//  Created by Carlos Roig on 26/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import UIKit
import FacebookCore
import GoogleSignIn
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigator: AppRootNavigator!
    var logoutService: LogoutListenService!
    
    public func application(_ application: UIApplication,  didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        createWindow()
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        FirebaseApp.configure()
        installRootNavigator()
        setupServices()

        return SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
    }
    
    public func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        let google =  GIDSignIn.sharedInstance().handle(url,
                                                        sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                        annotation: [:])
        let facebook =  SDKApplicationDelegate.shared.application(app, open: url, options: options)
        
        return facebook || google
    }
    
    // MARK: Private
    private func createWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
    }
    
    private func installRootNavigator() {
        navigator = AppRootNavigator(AuthenticationDependencies(),ProfileDependencies())
        navigator.installRootViewController(in: window!)
        window?.makeKeyAndVisible()
    }
    
    private func setupServices() {
        logoutService = LogoutListenService(NotificationCenter.default, self)
        logoutService.start()
    }
}

extension AppDelegate: LogoutListenServiceDelegate {
    func userDidLogout() {
        navigator.launchMainAuthentincation()
    }
}
