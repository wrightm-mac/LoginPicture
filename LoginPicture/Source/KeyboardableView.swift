//
//  KeyboardableView.swift
//  LoginPicture
//
//  Created by Michael Wright on 18/03/2017.
//  Copyright © 2017 wrightm@mac.com. All rights reserved.
//

import UIKit


open class KeyboardableView: UIView {

    // MARK:    Overrides...
    
    open override func layoutSubviews() {
        super.layoutSubviews()

        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        visitChildren(recurse: true) {
            view in
            
            if let textField = view as? UITextField {
                textField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: UIControlEvents.editingDidBegin)
                textField.addTarget(self, action: #selector(textFieldDidEndOnExit), for: UIControlEvents.editingDidEndOnExit)
            }
        }
    }
    
    
    // MARK:    Events...

    @objc private func keyboardWillShow(notification: NSNotification) {
        print("🙂 LoginPanelView.\(#function)")
        
        showKeyboard()
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        print("🙂 LoginPanelView.\(#function)")
        
        hideKeyboard()
    }
    
    @objc private func textFieldDidBeginEditing(sender: UITextField) {
        print("🙂 LoginPanelView.\(#function)")
        
        beginEditing(sender: sender)
    }
    
    @objc private func textFieldDidEndOnExit(sender: UITextField) {
        print("🙂 LoginPanelView.\(#function)")
        
        endEditing(sender: sender)
    }
    
    
    // MARK:    Behaviours -- override to capture keyboard events...
    
    open func showKeyboard() {}
    
    open func hideKeyboard() {}
    
    open func beginEditing(sender: UITextField) {}
    
    open func endEditing(sender: UITextField) {}
}
