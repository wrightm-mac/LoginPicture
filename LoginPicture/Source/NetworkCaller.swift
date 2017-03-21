//
//  NetworkCaller.swift
//  LoginPicture
//
//  Created by Michael Wright on 21/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


open class NetworkCall {
    
    public typealias NetworkResponseFunc = (Data?) -> Void
    
    
    // MARK:    Fields...
    
    private let basePath: String
    
    public private(set) var url: String
    
    public private(set) var headers = [String: String]()
    
    public private(set) var parameters = [String: String]()
    
    open var serviceName: String {
        return "topics"
    }

    
    // MARK:    Initialisers...
    
    public init(url: String) {
        self.url = url
        
        let configuration = Configuration()
        basePath = configuration["BaseUrl"].string
    }
    
    
    // MARK:    Methods...
    
    open func withHeader(name: String, value: String) -> NetworkCall {
        headers[name] = value
        
        return self
    }
    
    open func withParameter(name: String, value: String) -> NetworkCall {
        parameters[name] = value
        
        return self
    }
    
    open func get(callback: @escaping NetworkResponseFunc) {
        doCall(httpMethod: "GET", callback: callback)
    }
    
    open func post(callback: @escaping NetworkResponseFunc) {
        doCall(httpMethod: "POST", callback: callback)
    }
    
    private func doCall(httpMethod: String, callback: @escaping NetworkResponseFunc) {
        // Handle the parameters for this call...
        
        var allParameters = ""
        for (parameterName, parameterValue) in parameters {
            let parameter = "\(parameterName)=\(parameterValue)"
            
            if allParameters > "" {
                allParameters.append("&")
            }
            
            allParameters.append(parameter)
        }
    
        let pathWithParameters = (allParameters > "") ? "\(url)?\(allParameters)" : url
        guard let encodedPath = pathWithParameters.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            Logger.instance.error("could not encode url")
            return
        }
        
        // Set up the request for this call...
        
        let fullPath = "\(basePath)/\(serviceName)/\(encodedPath)"
        Logger.instance.debug("[fullPath=\(fullPath)]")
        
        guard let url = URL(string: fullPath) else {
            Logger.instance.error("could not create url")
            return
        }

        let request = NSMutableURLRequest(url: url)
        request.httpMethod = httpMethod
        
        // Handle the headers for this call...
        
        for (headerName, headerValue) in headers {
            request.setValue(headerName, forHTTPHeaderField: headerValue)
        }
        
        // Perform the request...
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            Logger.instance.debug("[data=\(data)][response=\(response)][error=\(error)]")
            
            guard error == nil else {
                Logger.instance.error("could not load image at '\(url)'")
                callback(nil)
                return
            }
            
            callback(data)
        }
        
        task.resume()
    }
}
