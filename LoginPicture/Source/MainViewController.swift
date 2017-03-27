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
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var framedImage: FramedImage!
    
    
    // MARK:    Constants...
    
    let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
    
    
    // MARK:    Overrides...
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Logger.instance.debug("hello, world!")

        loginPanel.onLogin {
            username, password in
            
            Logger.instance.info("username='\(username)' password='\(password)'")
            
            self.startActivityIndicator()
            
            let caller = AppDelegate.container.resolve(forType: INetworkDownloadCaller.self)!
            caller
                .authenticate(with: NetworkUserAuthenticator(username: username, password: password))
                .withHeader(name: "Content-Type", value: "application/x-www-form-urlencoded")
                .withHeader(name: "Host", value: "mobility.cleverlance.com")
                .post(url: "bootcamp/image.php") {
                    response in
                    
                    Logger.instance.debug("begin: post callback - response-length=\(response?.toString()?.characters.count ?? -1)")
                    defer {
                        self.stopActivityIndicator()
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
    
    override var shouldAutorotate: Bool {
        // Lock to portrait-mode whilst login-panel is hidden...
        return loginPanel?.isHidden ?? false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return loginPanel?.isHidden ?? false ? UIInterfaceOrientationMask.all : UIInterfaceOrientationMask.portrait
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if loginPanel.isHidden {
            setDisplayImageFrame(size: size)
        }
    }
    
    
    // MARK:    Methods...
    
    open func startActivityIndicator() {
        activityIndicator.centerInSuperview()
        activityIndicator.startAnimating()
    }
    
    open func stopActivityIndicator() {
        activityIndicator.stopAnimating()
    }

    private func setDisplayImageFrame(size: CGSize) {
        let isPortrait = UIDevice.current.orientation == .portrait
        Logger.instance.debug("orientation='\(isPortrait)'")
        
        
        let statusBarHeight = isPortrait ? self.statusBarHeight : 0.0
        framedImage.frame = CGRect(x: 0.0, y: statusBarHeight, width: size.width, height: size.height - statusBarHeight)
    }
}
