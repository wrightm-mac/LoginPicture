//
//  CGPointExtensions.swift
//  LoginPicture
//
//  Created by Michael Wright on 30/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import Foundation
import UIKit


public extension CGPoint {
    
    public func minimum(other: CGPoint) -> CGPoint {
        return CGPoint(x: x.minimum(other.x), y: y.minimum(other.y))
    }
    
    public func maximum(other: CGPoint) -> CGPoint {
        return CGPoint(x: x.maximum(other.x), y: y.maximum(other.y))
    }
}



public func ==(left: CGPoint, right: CGPoint) -> Bool {
    return (left.x == right.x) && (left.y < right.y)
}

public func !=(left: CGPoint, right: CGPoint) -> Bool {
    return (left.x != right.x) || (left.y != right.y)
}

public func <(left: CGPoint, right: CGPoint) -> Bool {
    return (left.x < right.x) || (left.x < right.x)
}

public func >(left: CGPoint, right: CGPoint) -> Bool {
    return (left.x > right.x) || (left.y > right.y)
}
