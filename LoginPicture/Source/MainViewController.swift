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
            
            let sha1Password = password.sha1
            let hex = sha1Password.hex
            let base64 = sha1Password.base64
            Logger.instance.info("hex='\(hex)' base64='\(base64)'")
            
            let caller = AppDelegate.container.resolve(forType: INetworkDownloadCaller.self)!
            
            caller
                .authenticate(username: username, password: password)
                .withHeader(name: "Content-Type", value: "application/x-www-form-urlencoded")
                .withHeader(name: "Host", value: "mobility.cleverlance.com")
                .body("username=\(username)")
                .post(url: "bootcamp/image.php") {
                    response in
                    
                    Logger.instance.debug("begin: post callback - response='\(response?.toString() ?? "***")'")
                    
                    guard let base64 = response?.toString(), let data = base64.fromBase64 else {
                        Logger.instance.warn("no data!")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        let image = UIImage(data: data)
                        self.displayImage.image = image
                    }
                    
                    Logger.instance.debug("end: post callback")
            }
        }
    }
}
