//
//  Presenter.swift
//  AudioBooks
//
//  Created by Carlos Roig on 14/08/2017.
//  Copyright © 2017 CRS. All rights reserved.
//

import Foundation

public protocol Presenter {
    func viewDidLoad()
    func viewWillAppear()
    func viewDidAppear()
}

extension Presenter {
    func viewDidLoad() {}
    func viewWillAppear() {}
    func viewDidAppear() {}
}
