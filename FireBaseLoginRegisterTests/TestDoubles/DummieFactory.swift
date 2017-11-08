//
//  DummieFactory.swift
//  FireBaseLoginRegisterTests
//
//  Created by Carlos Roig on 3/11/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

struct DummyFactory {
    static func dummy<T: AnyObject>(someClass: T.Type) -> T {
        return unsafeBitCast(NSObject(), to: someClass)
    }
}
