//
//  Storage.swift
//  minube
//
//  Created by Carlos Roig Salvador on 13/10/16.
//  Copyright © 2016 minube.com. All rights reserved.
//

import Foundation


protocol StorageCoordinator {
    func getItems<T:Serializable>(completion : @escaping ([T]?)-> Void )
    func save<T:Serializable>(_ items : [T], completion : @escaping (Bool)-> Void)
    func getItems<T:Serializable>()-> [T]?
    func removeAll()
}

extension StorageCoordinator {
    func save<T:Serializable>(_ items : [T], completion : @escaping (Bool)-> Void){}
    func getItems<T:Serializable>()-> [T]?{ return nil }
    func removeAll() {}
}
