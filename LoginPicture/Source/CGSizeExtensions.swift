//
//  CGSizeExtensions.swift
//  LoginPicture
//
//  Created by Michael Wright on 30/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation
import UIKit


public extension CGSize {
    
    public func scaled(by: CGFloat) -> CGSize {
        return CGSize(width: width * by, height: height * by)
    }
    
    public func scaled(x: CGFloat, y: CGFloat) -> CGSize {
        return CGSize(width: width * x, height: height * y)
    }
}



public func ==(left: CGSize, right: CGSize) -> Bool {
    return (left.width == right.width) && (left.height < right.height)
}

public func !=(left: CGSize, right: CGSize) -> Bool {
    return (left.width != right.width) || (left.height != right.height)
}

public func <(left: CGSize, right: CGSize) -> Bool {
    return (left.width < right.width) || (left.height < right.height)
}

public func >(left: CGSize, right: CGSize) -> Bool {
    return (left.width > right.width) || (left.height > right.height)
}
