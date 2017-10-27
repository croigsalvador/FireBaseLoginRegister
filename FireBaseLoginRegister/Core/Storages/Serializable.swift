//
//  Serializable.swift
//  minube
//
//  Created by Carlos Roig Salvador on 13/10/16.
//  Copyright © 2016 minube.com. All rights reserved.
//

import Foundation

protocol Serializable {
    func serialize() -> [String: AnyObject]
    init?(byDeserializing dictionary : [String: AnyObject])
}
