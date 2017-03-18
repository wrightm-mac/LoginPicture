//
//  StandardButton.swift
//  LoginPicture
//
//  Created by Michael Wright on 18/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import UIKit


@IBDesignable
open class StandardButton: UIButton {

    // MARK:    Inspectables...
    
    @IBInspectable open var color: UIColor? = .blue
    
    
    // MARK:    Overrides...
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        applyBorder(cornerSize: .small, width: .none)
        
        backgroundColor = color
    }
}
