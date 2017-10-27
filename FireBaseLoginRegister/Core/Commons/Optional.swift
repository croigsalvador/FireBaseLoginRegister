//
//  Optional.swift
//  minube
//
//  Created by Marcos Sorribas Lopez on 3/2/17.
//  Copyright © 2017 minube.com. All rights reserved.
//

import Foundation

extension Optional {
    func isNil() -> Bool { return self == nil }
}

extension Optional where Wrapped == String {
    func nilToEmpty() -> String {
        guard let element = self else {
            return ""
        }
        return element
    }
}

extension Optional where Wrapped == Bool {
    func nilToFalse() -> Bool {
        guard let element = self else {
            return false
        }
        return element
    }
    
    func nilToTrue() -> Bool {
        guard let element = self else {
            return true
        }
        return element
    }
}

extension Optional where Wrapped == NSNumber {
    func nilToZero() -> NSNumber {
        guard let n = self else {
            return NSNumber(value: 0)
        }
        return n
    }
}

extension Optional where Wrapped == Int {
    func nilToZero() -> Int {
        guard let i = self else {
            return 0
        }
        return i
    }
}

infix operator !!
func !! <T>(optional:T?, msg: String) -> T {
    guard let _ = optional else {
        fatalError(msg)
    }
    return optional!
}
