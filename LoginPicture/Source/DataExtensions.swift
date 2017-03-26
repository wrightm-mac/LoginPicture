//
//  DataExtensions.swift
//  LoginPicture
//
//  Created by Michael Wright on 26/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation


extension Data {
    
    func toString(encoding: String.Encoding = .utf8) -> String? {
        return String(data: self, encoding: encoding)
    }
}
