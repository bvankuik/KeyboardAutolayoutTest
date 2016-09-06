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
    @IBOutlet var textFieldTopLayoutGuideConstraint: NSLayoutConstraint!
    @IBOutlet weak var textField: UITextField!

    var textFieldTopLayoutGuideConstraintConstant: CGFloat?
    
    func keyboardWillShow(notification: NSNotification) {
        print("keyboardWillShow")
        self.textFieldTopConstraint.active = false
        self.textFieldTopLayoutGuideConstraint.active = true
        self.textFieldTopLayoutGuideConstraint.constant = 0
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
        if let constant = self.textFieldTopLayoutGuideConstraintConstant {
            self.textFieldTopLayoutGuideConstraint.constant = constant
        }
        UIView.animateWithDuration(1.0, animations: {
            self.view.layoutIfNeeded()

            }) { (finished) in
                self.textFieldTopLayoutGuideConstraint.active = false
                self.textFieldTopConstraint.active = true
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
        if let _ = textFieldTopLayoutGuideConstraintConstant {
            return
        } else {
            textFieldTopLayoutGuideConstraintConstant = textField.frame.origin.y
            print("textFieldTopLayoutGuideConstraintConstant=\(textFieldTopLayoutGuideConstraintConstant)")
        }
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
}

