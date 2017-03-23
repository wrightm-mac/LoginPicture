//
//  LoginPanel.swift
//  LoginPicture
//
//  Created by Michael Wright on 18/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import UIKit


@IBDesignable
open class LoginPanel: KeyboardableView {
    
    public typealias LoginFunc = (String, String) -> Void

    
    // MARK:    Fields...
    
    private weak var view: LoginPanelView! = nil
    
    private var loginFunc: LoginFunc? = nil
    
    
    // MARK:    Initialisers...
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        view = addSubviewFromNib() as! LoginPanelView
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        view = addSubviewFromNib() as! LoginPanelView
    }
    
    public init() {
        super.init(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 10.0))
        
        view = addSubviewFromNib() as! LoginPanelView
    }
    
    
    // MARK:    Overrides...
    
    open override func layoutSubviews() {
        super.layoutSubviews()
     
        view.applyBorder(cornerSize: .small, width: .medium, color: .black)
        
        view.parent = self
        view.backgroundColor = backgroundColor
    }
    
    open override func endEditing(sender: UITextField) {
        if sender == view.usernameTextField {
            view.passwordTextField.becomeFirstResponder()
        }
    }
    
    
    // MARK:    Methods...
    
    open func onLogin(callback: @escaping LoginFunc) {
        loginFunc = callback
    }
    
    open func loginPressed(username: String, password: String) {
        loginFunc?(username, password)
    }
}
