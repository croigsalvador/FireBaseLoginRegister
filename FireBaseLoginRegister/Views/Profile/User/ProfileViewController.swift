//
//  ProfileViewController.swift
//  ComparsApp
//
//  Created by Carlos Roig on 4/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    var presenter: ProfilePresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func logOutButtonPressed(_ sender: UIButton) {
        presenter.logOut()
    }
}
