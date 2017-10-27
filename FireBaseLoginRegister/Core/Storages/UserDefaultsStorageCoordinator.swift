//
//  UserDefaultsStorageCoordinator.swift
//  minube
//
//  Created by Carlos Roig Salvador on 24/10/16.
//  Copyright © 2016 minube.com. All rights reserved.
//

import Foundation


class UserDefaultsStorageCoordinator : NSObject, StorageCoordinator {
    
    static let UserDefaultsSynchronizeErrorDomain = "UserDefaultsSynchronizeErrorDomain"
    static let UserDefaultsSynchronizeErrorCode = 0
    
    let modelKey : String
    let userDefaults : UserDefaults
    let concurrentQueue = DispatchQueue(label: "minube.com.userDefaultsStorage", attributes: .concurrent)
    private let serializer : Serializer
    
    init(_ userDefaults : UserDefaults, modelKey : String, serializer : Serializer) {
        self.userDefaults = userDefaults
        self.modelKey = modelKey
        self.serializer = serializer
    }
    
    func getItems<T : Serializable>(completion: @escaping ([T]?) -> Void) {
        
        concurrentQueue.async {
            guard  let data = self.userDefaults.data(forKey: self.modelKey), let serializedItems = self.serializer.serializedItems(from: data), serializedItems.count > 0 else {
                completion(nil)
                return
            }
            completion(self.serializer.deserialize(serializedItems) as [T])
        }
    }
    
    func save<T : Serializable>(_ items: [T], completion: @escaping (Bool) -> Void) {
        self.concurrentQueue.async {
            guard let data = self.serializer.data(from: items) else {
                completion(false)
                return
            }
            
            self.userDefaults.set(data, forKey: self.modelKey)
            DispatchQueue.main.async {
                completion(self.synchronizeUserDefaults())
            }
        }
    }
    
    func getItems<T:Serializable>()-> [T]? {
        guard  let data = self.userDefaults.data(forKey: self.modelKey), let serializedItems = self.serializer.serializedItems(from: data), serializedItems.count > 0 else {
            return nil
        }
        return self.serializer.deserialize(serializedItems) as [T]
    }
    
    func removeAll() {
        userDefaults.removeObject(forKey: modelKey)
        userDefaults.synchronize()
    }
    
    
    func synchronizeUserDefaults() -> Bool {
        let synchronize = self.userDefaults.synchronize()
        return synchronize
    }
    
}
