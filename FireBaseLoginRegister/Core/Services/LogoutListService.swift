//
//  LogoutListService.swift
//  FireBaseLoginRegister
//
//  Created by Carlos Roig on 27/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

protocol LogoutListenServiceDelegate: class {
    func userDidLogout()
}

class LogoutListenService {
    
    weak var delegate:LogoutListenServiceDelegate!
    fileprivate let notificationCenter: NotificationCenter
    init(_ notificationCenter: NotificationCenter, _ delegate: LogoutListenServiceDelegate) {
        self.notificationCenter  = notificationCenter
        self.delegate = delegate
    }
    
    func start() {
        notificationCenter.addObserver(self, selector: #selector(userDidLogOut), name:.UserDidLogoutNotification, object:nil)
    }
    
    @objc func userDidLogOut() {
        delegate.userDidLogout()
    }
}
