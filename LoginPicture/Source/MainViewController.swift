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
            
            let caller = AppDelegate.container.resolve(forType: INetworkDownloadCaller.self)!
            
            caller
                .authenticate(username: username, password: password)
                .withHeader(name: "Content-Type", value: "application/x-www-form-urlencoded")
                .withHeader(name: "Host", value: "mobility.cleverlance.com")
                .body("username=\(username)")
                .post(name: "bootcamp/image.php") {
                    response in
                    
                    Logger.instance.debug("begin: post callback - response-length=\(response?.toString()?.characters.count ?? -1)")
                    
                    guard let data = response else {
                        Logger.instance.warn("response is nil")
                        return
                    }
                    
                    guard let json = data.json else {
                        Logger.instance.warn("cannot parse json from response")
                        return
                    }
                    
                    guard let imageString = json["image"] as? String else {
                        Logger.instance.warn("response json has no 'image' element")
                        return
                    }
                    
                    guard let unencodedImageData = imageString.fromBase64 else {
                        Logger.instance.warn("cannot decode image base64")
                        return
                    }
                    
                    DispatchQueue.main.async {
                        let image = UIImage(data: unencodedImageData)
                        self.displayImage.image = image
                    }
                    
                    Logger.instance.debug("end: post callback")
            }
        }
    }
}
