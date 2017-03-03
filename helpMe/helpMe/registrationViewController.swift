//
//  registrationViewController.swift
//  helpMe
//
//  Created by Александр on 03.03.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class registrationViewController: UIViewController {

    @IBOutlet weak var redVector: UIImageView!
    @IBOutlet weak var yellowVector: UIImageView!
    @IBOutlet weak var greenVector: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var familyTextField: UITextField!
    @IBOutlet weak var phoneNumbertextfiled: UITextField!
    @IBOutlet weak var nameIcon: UIImageView!
    @IBOutlet weak var familyIcon: UIImageView!
    @IBOutlet weak var phoneIcon: UIImageView!
    
    @IBAction func registrationButton(_ sender: Any) {
        updateUI()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateUI(){
        if (nameTextField.text?.isEmpty == false){
            redVector.image = #imageLiteral(resourceName: "redVector")
            nameIcon.image = #imageLiteral(resourceName: "redNameIcon")
        }
        if (familyTextField.text?.isEmpty == false){
            yellowVector.image = #imageLiteral(resourceName: "yellowVektor")
            familyIcon.image = #imageLiteral(resourceName: "yellowNameIcon")
        }
        if (phoneNumbertextfiled.text?.isEmpty == false){
            greenVector.image = #imageLiteral(resourceName: "greentVector")
            phoneIcon.image = #imageLiteral(resourceName: "colorTelephoneIcon")
        }
    }
}
