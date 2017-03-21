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
        
        let container = Container() {
            container in
            
            container.register(forType: String.self) { "yada yada yada!"}
            container.register(forType: Int.self) { 2108 }
        }
        
        let x = container.resolve(forType: Int.self)
        let y = container.resolve(forType: String.self)
        
        Logger.instance.event(" x='\(x)' y='\(y)'")
    }
}
