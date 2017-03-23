//
//  MainViewController.swift
//  LoginPicture
//
//  Created by Michael Wright on 18/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {

    @IBOutlet weak var loginPanel: LoginPanel!
    @IBOutlet weak var displayImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Logger.instance.debug("hello, world!")
        
        loginPanel.onLogin {
            username, password in
            
            Logger.instance.info("username='\(username)' password='\(password)'")
            
            let caller = AppDelegate.container.resolve(forType: INetworkCaller.self)!
            
            caller
                .authenticate(username: username, password: password)
                .withHeader(name: "Auth-abc", value: "123")
                .withHeader(name: "Auth-pqr", value: "456")
                .withHeader(name: "Auth-xyz", value: "789")
                .withParameter(name: "first", value: "one&x")
                .withParameter(name: "second", value: "two z z z")
                .withParameter(name: "third", value: "three")
                .post(url: "space_64.png") {
                    data in
                    
                    DispatchQueue.main.async {
                        let image = UIImage(data: data!)
                        self.displayImage.image = image
                    }
                    
                    Logger.instance.debug("kerching!!!")
            }
        }
    }
}
