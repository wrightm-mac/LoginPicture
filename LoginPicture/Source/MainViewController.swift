//
//  MainViewController.swift
//  LoginPicture
//
//  Created by Michael Wright on 18/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Logger.instance.debug("hello, world!")
        Logger.instance.info("hello, world!")
        Logger.instance.event("hello, world!")
        Logger.instance.warn("hello, world!")
        Logger.instance.error("hello, world!")
    }
}
