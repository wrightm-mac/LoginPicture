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
    
    public private(set) var body = ""
    
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
    
    open func body(_ contents: String) -> INetworkCaller {
        body = contents
        
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

    private func doCall(url: String,  httpMethod: String, callback: @escaping NetworkCallResponseFunc) {
        // Build a string of parameters to be appended to the url...
        var allParameters = ""
        for (parameterName, parameterValue) in parameters {
            let parameter = "\(parameterName)=\(parameterValue)"
            
            if allParameters > "" {
                allParameters.append("&")
            }
            
            allParameters.append(parameter)
        }
    
        // Append the parameter string to the url & encode to make it safe...
        let pathWithParameters = (allParameters > "") ? "\(url)?\(allParameters)" : url
        guard let encodedPath = pathWithParameters.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) else {
            Logger.instance.error("could not encode url")
            return
        }
        
        // The full url for the call will be the basepath + service-name + parameters...
        let fullPath = "\(basePath)/\(serviceName)/\(encodedPath)"

        // Call the function that will make the call...
        invoke(httpMethod: httpMethod, fullPath: fullPath, headers: headers, body: body, callback: callback)
    }
    
    /**
        Makes a network call based on the all of the information known at this
        point.
     
        Override this call to change the call mechanism.
     
        - parameter httpMethod: HTTP method to invoke.
        - parameter fullPath:   The full path of the service to invoke - this will contain any parameters.
        - parameter headers:    All headers for the call - these will include any session/auth headers.
        - parameter body:       The body of the call.
        - parameter callback:   The function to be invoked when the call has completed.
    */
    open func invoke(httpMethod: String, fullPath: String, headers: [String: String], body: String, callback: @escaping NetworkCallResponseFunc) {
        guard let url = URL(string: fullPath) else {
            Logger.instance.error("could not create url")
            callback(nil)
            return
        }
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = httpMethod
        
        // Handle the headers for this call...
        
        for (headerName, headerValue) in headers {
            request.setValue(headerValue, forHTTPHeaderField: headerName)
        }
        
        
        // Set the request body...
        
        request.httpBody = body.toData()
        
        
        // Perform the request...
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            guard error == nil else {
                Logger.instance.warn("error loading from '\(fullPath)' - (\(error))")
                callback(nil)
                return
            }
            
            callback(data)
        }
        
        task.resume()
    }
}
