//
//  NetworkCaller.swift
//  LoginPicture
//
//  Created by Michael Wright on 21/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


open class NetworkCaller: INetworkCaller {
    
    // MARK:    Fields...
    
    private let basePath: String
    
    public private(set) var headers = [String: String]()
    
    public private(set) var parameters = [String: String]()
    
    open var serviceName: String {
        return "topic"
    }

    
    // MARK:    Initialisers...
    
    public init() {
        let configuration = Configuration()
        basePath = configuration["BaseUrl"].string
    }
    
    
    // MARK:    'INetworkCaller'...
    
    open func withHeader(name: String, value: String) -> INetworkCaller {
        headers[name] = value
        
        return self
    }
    
    open func withParameter(name: String, value: String) -> INetworkCaller {
        parameters[name] = value
        
        return self
    }
    
    open var authenticator: INetworkAuthenticator? {
        return NetworkUserAuthenticator()
    }
    
    open func authenticate(username: String, password: String) -> INetworkCaller {
        if let authenticator = authenticator {
            authenticator.authenticate(with: self, username: username, password: password)
        }
        
        return self
    }
    
    open func get(url: String, callback: @escaping NetworkCallResponseFunc) {
        doCall(url: url, httpMethod: "GET", callback: callback)
    }
    
    open func post(url: String, callback: @escaping NetworkCallResponseFunc) {
        doCall(url: url, httpMethod: "POST", callback: callback)
    }
    
    open func put(url: String, callback: @escaping NetworkCallResponseFunc) {
        doCall(url: url, httpMethod: "PUT", callback: callback)
    }
    
    open func delete(url: String, callback: @escaping NetworkCallResponseFunc) {
        doCall(url: url, httpMethod: "DELETE", callback: callback)
    }
    
    
    // MARK:    Methods...

    open func doCall(url: String,  httpMethod: String, callback: @escaping NetworkCallResponseFunc) {
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
        Logger.instance.debug("*********** [fullPath=\(fullPath)]")
        
        guard let url = URL(string: fullPath) else {
            Logger.instance.error("could not create url")
            return
        }

        let request = NSMutableURLRequest(url: url)
        request.httpMethod = httpMethod
        
        // Handle the headers for this call...
        
        for (headerName, headerValue) in headers {
            request.setValue(headerValue, forHTTPHeaderField: headerName)
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
