//
//  DusButton.swift
//  HelpMeSecurity
//
//  Created by Александр on 20.04.17.
//  Copyright © 2017 Александр. All rights reserved.
//

import UIKit

class DusButton: UIButton {

    let checkImage = UIImage(named: "deghurstvo")! as UIImage
    let unCheckImage = UIImage(named: "zvershit")! as UIImage
    
    var isCheked:Bool = true{
        didSet{
            if isCheked == true{
                self.setImage(checkImage, for: .normal)
               // self.tintColor = UIColor.black
            } else{
                self.setImage(unCheckImage, for: .normal)
               // self.tintColor = UIColor.red
            }
        }
    }
    
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
    }
    
    
    func buttonClicked(sender: UIButton){
        if(sender == self){
            if (isCheked == true){
                isCheked = false
            } else {
                isCheked = true
            }
        }
    }


}
