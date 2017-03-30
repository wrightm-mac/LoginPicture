//
//  ScrollableImage.swift
//  LoginPicture
//
//  Created by Michael Wright on 30/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import UIKit


@IBDesignable
open class ScrollableImage: UIView {
    
    // MARK:    Inspectables...
    
    @IBInspectable open var allowPan: Bool = true
    
    @IBInspectable open var allowZoom: Bool = true
    
    @IBInspectable open var maximumZoomFactor: CGFloat = 3.0 {
        didSet {
            if maximumZoomFactor <= 0.0 {
                maximumZoomFactor = 0.1
            }
            else if maximumZoomFactor > 5.0 {
                maximumZoomFactor = 5.0
            }
        }
    }
    
    @IBInspectable open var image: UIImage? = nil {
        didSet {
            view.imageView.image = image
        }
    }
    
    
    // MARK:    Fields...
    
    private weak var view: ScrollableImageView!
    
    public private(set) var maximumImageSize: CGSize = CGSize()
    
    
    // MARK:    Initialisers...
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        view = addSubviewFromNib() as! ScrollableImageView
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        view = addSubviewFromNib() as! ScrollableImageView
    }
    
    public init() {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0))
        
        view = addSubviewFromNib() as! ScrollableImageView
    }
    
    
    // MARK:    Overrides...
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        
        view.backgroundColor = backgroundColor
        
        if let image = view.imageView.image {
            maximumImageSize = image.size.scaled(by: maximumZoomFactor)
        }
        else {
            maximumImageSize = CGSize(width: 0.0, height: 0.0)
        }
    }
}
