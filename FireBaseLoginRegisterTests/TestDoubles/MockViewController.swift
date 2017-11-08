//
//  MockViewController.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 3/11/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation
import UIKit

class MockViewController: UIViewController {
    
    var presentCalled = false
    var dismissCalled = false
    
    override func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        presentCalled = true
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        dismissCalled = false
    }
}
