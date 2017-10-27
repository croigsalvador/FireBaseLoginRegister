//
//  EventRouter.swift
//  ComparsApp
//
//  Created by Carlos Roig on 08/09/2017.
//  Copyright © 2017 CRS. All rights reserved.
//

import UIKit

protocol RootNavigatorProtocol {
    var tabBarController: UITabBarController? {get set}
    var currentNavigationController: UINavigationController? {get set}
    var currentlyPresentedViewController: UIViewController? {get}
    var currentlyPresentedNavigationController: UINavigationController? {get}
    func dismiss()
    func pop()
}

class RootNavigator:NSObject,RootNavigatorProtocol {
    
    var tabBarController: UITabBarController?
    var currentNavigationController: UINavigationController?
    var currentlyPresentedViewController: UIViewController? {
        return currentNavigationController?.presentedViewController
    }
    var currentlyPresentedNavigationController: UINavigationController? {
        return currentNavigationController?.presentedViewController as? UINavigationController
    }
    
    func dismiss() {
        currentNavigationController?.dismiss(animated: true, completion: {})
    }
    
    func pop() {
        currentNavigationController?.popViewController(animated: true)
    }
    
}
