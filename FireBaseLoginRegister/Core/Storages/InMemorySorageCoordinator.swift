//
//  InMemorySorageCoordinator.swift
//  minube
//
//  Created by Carlos Roig Salvador on 30/11/16.
//  Copyright © 2016 minube.com. All rights reserved.
//

import Foundation

class InMemoryStorageCoordinator: StorageCoordinator {
    
    typealias Element = Serializable
    var elements: [Element]?
    
    func getItems<T : Serializable>(completion: @escaping ([T]?) -> Void) {
        completion(self.elements as! [T]?)
    }
    
    func save<T : Serializable>(_ items: [T], completion: @escaping (Bool) -> Void) {
        elements = items
        completion(true)
    }

}
