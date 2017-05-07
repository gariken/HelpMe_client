//
//  ViewController.swift
//  helpMe
//
//  Created by Александр on 24.01.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit
import AKMaskField

class ViewController: UIViewController {

    var click : Bool?
    
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func passwordButtonClick(_ sender: Any) {
        if (click==true){
            passwordTextField.isSecureTextEntry = false
            click = false
            passwordButton.setImage(UIImage(named: "showPassword"), for: UIControlState.normal)
        } else{
            passwordTextField.isSecureTextEntry = true
            click = true
            passwordButton.setImage(UIImage(named: "hidePassword"), for: UIControlState.normal)
        }
    }
    @IBAction func signIn(_ sender: Any) {
        self.performSegue(withIdentifier: "signIn", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        click = true
        registerForKeyboardNotifications()
    }
    
    deinit {
        removeKeyboardNotification()
    }

    
    func registerForKeyboardNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(kbWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

    }
    
    func removeKeyboardNotification(){
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func kbWillShow(_ notification: Notification){
        let userInfo = notification.userInfo
        let kbFrameSize = (userInfo?[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        scrollView.contentOffset = CGPoint(x: 0, y: kbFrameSize.height)
    }
    
    func kbWillHide(){
        scrollView.contentOffset = CGPoint.zero
    }

}

