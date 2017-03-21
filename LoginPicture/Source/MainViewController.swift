//
//  MainViewController.swift
//  LoginPicture
//
//  Created by Michael Wright on 18/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import UIKit


class MainViewController: UIViewController {

    @IBOutlet weak var displayImage: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Logger.instance.debug("hello, world!")
        
        let networkService = NetworkService()
        
        networkService.fetchImage(imageName: "space_64.png") {
            image in
            
            guard let fetchedImage = image else {
                Logger.instance.error("no image!")
                return
            }
            
            DispatchQueue.main.async {
                self.displayImage.image = fetchedImage
            }
        }
    }
}
