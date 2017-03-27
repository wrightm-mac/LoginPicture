//
//  NetworkCaller.swift
//  LoginPicture
//
//  Created by Michael Wright on 21/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


/**
    Implements a network call.
 
    Ultimately, the full-url of the network call is built from 3 elements:
 
    - *base-url* - this is read from the `Configuration.plist` file.
    - *service-name* - this provided from the `serviceName` property. Derived classes
                        should override this property to provide a meaningful name.
    - *name* - the name of the method of the service to invoke.
 
    The full *URL*, that will be passed to the `invoke` function for action, will
    be of the form: `<base-path>/<service-name>/<method-name>?<parameter-list>`.
*/
open class NetworkCaller: INetworkCaller {
    
    // MARK:    Fields...
    
    private let basePath: String
    
    public private(set) var headers = [String: String]()
    
    public private(set) var parameters = [String: String]()
    
    public private(set) var body = ""
    
    /**
        Override this property to provide a meaningful name for your network service.
    */
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
    
    open func body(content: String) -> INetworkCaller {
        body = content
        
        return self
    }

    open func authenticate(with authenticator: INetworkAuthenticator) -> INetworkCaller {
        authenticator.authenticate(with: self)
        
        return self
    }
    
    open func get(url name: String, callback: @escaping NetworkCallResponseFunc) {
        doCall(name: name, httpMethod: "GET", callback: callback)
    }
    
    open func post(url name: String, callback: @escaping NetworkCallResponseFunc) {
        doCall(name: name, httpMethod: "POST", callback: callback)
    }
    
    open func put(url name: String, callback: @escaping NetworkCallResponseFunc) {
        doCall(name: name, httpMethod: "PUT", callback: callback)
    }
    
    open func delete(url name: String, callback: @escaping NetworkCallResponseFunc) {
        doCall(name: name, httpMethod: "DELETE", callback: callback)
    }
    
    
    // MARK:    Methods...

    private func doCall(name: String,  httpMethod: String, callback: @escaping NetworkCallResponseFunc) {
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
        let pathWithParameters = (allParameters > "") ? "\(name)?\(allParameters)" : name
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
