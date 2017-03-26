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
    @IBOutlet weak var framedImage: FramedImage!
    
    
    // MARK:    Overrides...
    
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
                    defer {
                        Logger.instance.debug("end: post callback")
                    }
                    
                    guard let data = response else {
                        Logger.instance.warn("response is nil")
                        return
                    }
                    
                    guard let json = data.json else {
                        Logger.instance.warn("cannot parse json from response")
                        return
                    }
                    
                    guard let imageBase64 = json["image"] as? String else {
                        Logger.instance.warn("response json has no 'image' element")
                        return
                    }
                    
                    guard let unencodedImageData = imageBase64.fromBase64 else {
                        Logger.instance.warn("cannot decode image base64")
                        return
                    }
                    
                    guard let image = UIImage(data: unencodedImageData) else {
                        Logger.instance.warn("cannot create image")
                        return
                    }
                    
                    Logger.instance.info("login response success - setting image")

                    DispatchQueue.main.async {
                        self.loginPanel.isHidden = true
                        self.framedImage.isHidden = false
                        self.setDisplayImageFrame(size: UIScreen.main.bounds.size)
                        self.framedImage.image = image
                    }
            }
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if loginPanel.isHidden {
            setDisplayImageFrame(size: size)
        }
    }
    
    
    // MARK:    Methods...
    
    private func setDisplayImageFrame(size: CGSize) {
        framedImage.frame = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
    }
}
