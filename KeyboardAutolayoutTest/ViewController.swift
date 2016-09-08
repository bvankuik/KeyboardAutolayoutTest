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
        if let originY = self.textFieldOriginY, let originalConstant = textFieldTopConstraintConstant {
            let newConstant = originY - originalConstant - topLayoutGuide.length
            self.textFieldTopConstraint.constant = -newConstant
        }
        
        UIView.animateWithDuration(0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let constant = self.textFieldTopConstraintConstant {
            self.textFieldTopConstraint.constant = constant
        }
        UIView.animateWithDuration(0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillShow(_:)),
                                                         name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.keyboardWillHide(_:)),
                                                         name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        if textFieldOriginY == nil {
            // Save vertical position
            textFieldOriginY = textField.frame.origin.y
        }
        
        if textFieldTopConstraintConstant == nil {
            // Save original constraint its constant
            textFieldTopConstraintConstant = textFieldTopConstraint.constant
        }
    }
}

