//
//  ViewController.swift
//  KeyboardAutolayoutTest
//
//  Created by Bart van Kuik on 06/09/16.
//  Copyright © 2016 DutchVirtual. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textFieldTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField!

    var textFieldTopConstraintConstant: CGFloat?
    var textFieldOriginY: CGFloat?
    
    func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow")
        if let originY = self.textFieldOriginY {
            print("originY=\(originY)")
            self.textFieldTopConstraint.constant = -originY + topLayoutGuide.length + 22
        }
        UIView.animateWithDuration(1.0, animations: {
            self.view.layoutIfNeeded()
            }) { (finished) in
        }
    }
    
    func keyboardDidShow(notification: NSNotification) {
        print("keyboardDidShow")
    }
    
    func keyboardWillHide(notification: NSNotification) {
        print("keyboardWillHide")
        if let constant = self.textFieldTopConstraintConstant {
            print("constant=\(constant)")
            self.textFieldTopConstraint.constant = constant
        }
        UIView.animateWithDuration(1.0, animations: {
            self.view.layoutIfNeeded()

            }) { (finished) in
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardDidShow(_:)),
                                                         name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow(_:)),
                                                         name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide(_:)),
                                                         name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    override func viewDidLayoutSubviews() {
        if let _ = textFieldOriginY {
            return
        } else {
            textFieldOriginY = textField.frame.origin.y
            print("textFieldOriginY=\(textFieldOriginY)")
        }
        
        if let _ = textFieldTopConstraintConstant {
            return
        } else {
            textFieldTopConstraintConstant = textFieldTopConstraint.constant
        }
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

