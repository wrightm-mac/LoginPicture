//
//  FramedImage.swift
//  LoginPicture
//
//  Created by Michael Wright on 26/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import UIKit


@IBDesignable
open class FramedImage: UIView {

    // MARK:    Inspectables...
    
    @IBInspectable open var image: UIImage? = nil {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable open var borderColor: UIColor? = .white {
        didSet {
            setNeedsLayout()
        }
    }
    
    @IBInspectable open var borderWidth: CGFloat = 12.0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    
    // MARK:    Fields...
    
    private weak var view: FramedImageView! = nil
    
    
    // MARK:    Initialisers...
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        view = addSubviewFromNib() as! FramedImageView
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        view = addSubviewFromNib() as! FramedImageView
    }
    
    public init() {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0))
        
        view = addSubviewFromNib() as! FramedImageView
    }
    
    
    // MARK:    Overrides...
    
    open override func layoutSubviews() {

        view.borderColor = borderColor ?? .white
        view.borderWidth = borderWidth
        view.scrollableImage.image = image
    
        super.layoutSubviews()
    }
}
