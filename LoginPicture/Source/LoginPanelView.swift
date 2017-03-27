//
//  LoginPanelView.swift
//  LoginPicture
//
//  Created by Michael Wright on 18/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import UIKit


class LoginPanelView: UIView {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    typealias LoginPressedFunc = (String, String) -> Void
    
    
    // MARK:    Fields...
    
    weak var parent: LoginPanel? = nil
    
    
    // MARK:    Overrides...
    
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        //usernameTextField.applyBorder(cornerSize: .small, width: .thick, color: .white)
    }
    
    
    // MARK:    Methods...
    
    override func resignFirstResponder() -> Bool {
        if usernameTextField.isFirstResponder {
            usernameTextField.resignFirstResponder()
        }
        else if passwordTextField.isFirstResponder {
            passwordTextField.resignFirstResponder()
        }
        
        return true
    }
    
    
    // MARK:    Events...
    
    @IBAction func loginTouchUpInside(_ sender: UIButton) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else {
            return
        }
        
        _ = resignFirstResponder()
        
        parent?.loginPressed(username: username, password: password)
    }
}
