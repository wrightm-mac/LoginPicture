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
    
    
    typealias LoginPressedFunc = (String, String) -> Void
    
    
    // MARK:    Fields...
    
    var loginPressedFunc: LoginPressedFunc? = nil
    
    
    // MARK:    Overrides...
    
    open override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    // MARK:    Methods...
    
    func onLoginPressed(callback: @escaping LoginPressedFunc) {
        loginPressedFunc = callback
    }
    
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
        loginPressedFunc?(username, password)
    }
}
