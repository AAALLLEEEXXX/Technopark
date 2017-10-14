//
//  ViewController.swift
//  WhatToday
//
//  Created by Алексей on 10.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var threeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        threeButton.applyDesign3()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }

}

extension UIButton{
    func  applyDesign3(){
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = self.frame.height / 2
        self.setTitleColor(UIColor.blue, for: .normal)
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
}
}

