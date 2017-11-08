//
//  MockNotificationCenter.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 3/11/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
@testable import FireBaseLoginRegister

class MockNotificationCenter: NotificationCenter {
    
    var postCalled = 0
    
    override func post(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable : Any]? = nil) {
        postCalled += 1
    }
}
