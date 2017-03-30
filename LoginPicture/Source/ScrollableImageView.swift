//
//  ScrollableImageView.swift
//  LoginPicture
//
//  Created by Michael Wright on 30/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import UIKit


class ScrollableImageView: UIView {
    
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    // MARK:    Fields...
    
    private weak var parent: ScrollableImage? = nil
    
    public private(set) var minimumImageSize: CGSize = CGSize()
    
    
    // MARK:    Overrides...
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        debug(.orange)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        parent = superview as? ScrollableImage
        
        minimumImageSize = imageView.frame.size
    }
    
    
    // MARK:    Events...
    
    @IBAction func panGesture(_ sender: UIPanGestureRecognizer) {
        guard let parent = parent, parent.allowPan, let view = sender.view else {
            return
        }
        
        let translation = sender.translation(in: view)
        view.center = CGPoint(x:view.center.x + translation.x, y:view.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
        
        if (view.frame.size < frame.size) && ((translation.x < 1.0) || (translation.y < 1.0)) {
            view.frame.origin = CGPoint(x: 0.0, y: 0.0).maximum(other: view.frame.origin)
        }
    }
    
    @IBAction func pinchGesture(_ sender: UIPinchGestureRecognizer) {
        guard let parent = parent, parent.allowZoom, let view = sender.view else {
            return
        }
        
        let transformedSize = view.frame.size.scaled(by: sender.scale)
        if ((sender.scale < 1.0) && (transformedSize > frame.size)) || ((sender.scale > 1.0) && (transformedSize < parent.maximumImageSize)) {
            view.transform = (view.transform.scaledBy(x: sender.scale, y: sender.scale))
        }
        
        sender.scale = 1
    }
}
