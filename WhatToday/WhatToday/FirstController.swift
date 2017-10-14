//
//  FirstController.swift
//  WhatToday
//
//  Created by Алексей on 14.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

import Foundation
import UIKit

class FirstController: UIViewController {
    

    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    
    
override func viewDidLoad() {
    super.viewDidLoad()
  
    firstButton.applyDesign1()
    secondButton.applyDesign3()
}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    
}




extension UIButton{
    func  applyDesign1(){
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.blue, for: .normal)
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func  applyDesign2(){
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.blue, for: .normal)
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
}
