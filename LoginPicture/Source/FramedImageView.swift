//
//  FramedImageView.swift
//  LoginPicture
//
//  Created by Michael Wright on 26/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import UIKit


class FramedImageView: UIView {

    @IBOutlet weak var imageView: UIImageView!

    var borderColor: UIColor = .purple
    var borderWidth: CGFloat = 1.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        Logger.instance.debug("image-scale=\(self.imageView.image?.scale)")
        
        imageView.applyBorder(cornerSize: .small, width: .medium, color: .black)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backgroundColor = borderColor
        imageView.frame = CGRect(x: borderWidth, y: borderWidth,
                                 width: frame.width - borderWidth * 2.0, height: frame.height - borderWidth * 2.0)
    }
    
    @IBAction func pinchScale(_ sender: UIPinchGestureRecognizer) {
        imageView.transform = imageView.transform.scaledBy(x: sender.scale, y: sender.scale)
        sender.scale = 1
    }
}
