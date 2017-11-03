//
//  Result.swift
//  FireBaseLoginRegister
//
//  Created by Carlos Roig on 3/11/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

enum Result<T, Error> {
    case success(T?)
    case failure(Error)
}

