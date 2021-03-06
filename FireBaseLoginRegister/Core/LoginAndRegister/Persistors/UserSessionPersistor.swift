//
//  UserSessionPersistor.swift
//  ComparsApp
//
//  Created by Carlos Roig on 4/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

protocol UserSessionPersistorProtocol {
    func save(_ user: UserSession, completion:@escaping (Bool) -> Void)
    func removeUser()
    func getUser() -> UserSession?
}

struct UserSessionPersistor: UserSessionPersistorProtocol {
    
    private let storage : StorageCoordinator
   
    init(_ storage : StorageCoordinator) {
        self.storage = storage
    }
    
    func save(_ user: UserSession, completion:@escaping (Bool) -> Void) {
        storage.save([user], completion: completion)
    }

    func removeUser(){
        storage.removeAll()
    }

    func getUser() -> UserSession? {
        return storage.getItems()?.first
    }
}
