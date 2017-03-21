//
//  NetworkService.swift
//  LoginPicture
//
//  Created by Michael Wright on 21/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation
import UIKit


open class NetworkService {
    
    // MARK:    Fields...
    
    let basePath: String
    
    let serviceCall: String
    
    
    // MARK:    Initialisers...
    
    public init() {
        let configuration = Configuration()
        basePath = configuration["BaseUrl"].string
        serviceCall = configuration["ServiceCall"].string
    }
    
    
    // MARK:    Methods...
    
    open func fetchImage(imageName: String, callback: @escaping (UIImage?) -> Void) {
        let fullPath = "\(basePath)/topics/\(imageName)"
        
        guard let url = URL(string: fullPath) else {
            Logger.instance.error("could not create url")
            return
        }
        
        Logger.instance.debug("[full-path=\(fullPath)]")
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            Logger.instance.debug("[data=\(data)][response=\(response)][error=\(error)]")
            
            guard error == nil else {
                Logger.instance.error("could not load image at '\(fullPath)'")
                return
            }
            
            guard let imageData = data else {
                Logger.instance.error("no data")
                return
            }
            
            let image = UIImage(data: imageData)
            
            callback(image)
        }
        
        task.resume()
    }
}
