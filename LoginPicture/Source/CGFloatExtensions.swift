//
//  CGFloatExtensions.swift
//  LoginPicture
//
//  Created by Michael Wright on 30/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation
import UIKit

public extension CGFloat {
    
    public func minimum(_ other: CGFloat) -> CGFloat {
        return self < other ? self : other
    }
    
    public func maximum(_ other: CGFloat) -> CGFloat {
        return self > other ? self : other
    }
}
