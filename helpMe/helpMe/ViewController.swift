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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        click = true
    }

    func setupPassword(){
        
    }

}

