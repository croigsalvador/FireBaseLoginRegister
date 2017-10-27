//
//  AppRootNavigator.swift
//  ComparsApp
//
//  Created by Carlos Roig on 4/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import UIKit

class AppRootNavigator: RootNavigator {
    
    fileprivate let tabNavigatorCoordinator: TabNavigatorCoordinator = TabNavigatorCoordinator()
    
    func appRootViewController() {
        tabBarController?.selectedIndex = 1
        tabBarController?.delegate = self
        window.rootViewController = tabBarController
    }
    
    var window: UIWindow!
    let walkthroughDependencies: WalkthroughDependencies
    
    init(walkthroughDependencies: WalkthroughDependencies) {
        self.walkthroughDependencies = walkthroughDependencies
        super.init()
        self.walkthroughDependencies.navigator = self
    }
    
    func installRootViewController(in window:UIWindow) {
        self.window = window
        tabBarController = tabBarBuilder().buildTabBar(with: tabNavigatorCoordinator.navigators,parent: self)
        if isLogged {
            appRootViewController()
        } else {
            walkthroughViewController()
        }
    }
    
    fileprivate func  walkthroughViewController() {
        let initialViewController = UINavigationController.init(rootViewController: walkthroughDependencies.walkThroughViewController())
        currentNavigationController = initialViewController
        window.rootViewController = initialViewController
    }
    
    fileprivate var isLogged: Bool {
        let sessionPersistor = UserSessionPersistor(UserDefaultsStorageCoordinator(UserDefaults.standard, modelKey: "UserSession", serializer:ItemSerializer()))
        return sessionPersistor.getUser() != nil
    }
    
    private func tabBarBuilder() -> TabBarBuilder {
        return TabBarBuilder()
    }

}

extension AppRootNavigator: UITabBarControllerDelegate {
    
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let index = tabBarController.viewControllers?.index(of: viewController)
        
        if index != NSNotFound {
            if !isLogged {
                walkthroughViewController()
            } else {
                if index == 2 {
                    self.tabBarController?.selectedIndex = tabBarController.selectedIndex
                    tabNavigatorCoordinator.createEvent()
                    return false
                }
            }
        }
        return true 
    }
}

struct TabNavigatorCoordinator {
     let navigators: [TabNavigator]

    init() {
        let builder = NavigatorsBuilder()
        self.navigators = builder.build()
    }
    
    func createEvent() {
        createEventNavigator.launchCreateEventAssistant()
    }
    
    fileprivate var groupNavigator: GroupRootNavigator {
        return navigators[0] as! GroupRootNavigator
    }
    
    fileprivate var eventNavigator: EventRootNavigator {
        return navigators [1] as! EventRootNavigator
    }
    
    fileprivate var createEventNavigator: CreateEventRootNavigator {
        return navigators [2] as! CreateEventRootNavigator
    }
    
    fileprivate var profileNavigator: ProfileNavigator {
        return navigators[3] as! ProfileNavigator
    }
    
}
