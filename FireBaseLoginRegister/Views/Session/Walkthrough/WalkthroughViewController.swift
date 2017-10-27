//
//  WalkthroughViewController.swift
//  ComparsApp
//
//  Created by Carlos Roig on 3/10/17.
//  Copyright © 2017 CRS. All rights reserved.
//

import UIKit

class WalkthroughViewController: UIViewController {

    var presenter: WalkThroughPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func facebookButtonTapped(_ sender: UIButton) {
        presenter.facebook()
    }

    @IBAction func googleButtonPressed(_ sender: Any) {
        presenter.google()
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        presenter.login()
    }
    
    @IBAction func registerButtonPressed(_ sender: UIButton) {
        presenter.register()
    }
}
