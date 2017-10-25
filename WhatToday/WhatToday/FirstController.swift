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
    
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
  var menuVC: MenuViewController!
    
override func viewDidLoad() {
    super.viewDidLoad()
  
    firstButton.applyDesign1()
    secondButton.applyDesign3()
    
    menuVC = self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuViewController
    
    let  swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
    swipeRight.direction = .right
    
    let  swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipe))
    swipeLeft.direction = .left
    
    self.view.addGestureRecognizer(swipeRight)
    self.view.addGestureRecognizer(swipeLeft)
}
    
    @objc func  handleSwipe(gesture: UISwipeGestureRecognizer){
        switch gesture.direction {
        case UISwipeGestureRecognizerDirection.right:
            print("Right")
            showMenu()
        case UISwipeGestureRecognizerDirection.left:
            print("Left")
            hideMenu()
        default: break
        }
    }
    
    @IBAction func menuBarButtonItem(_ sender: UIBarButtonItem){
        if AppDelegate.isMenuVC {
            showMenu()
        } else{
            hideMenu()
        }
    }
    
    func showMenu() {
        UIView.animate(withDuration: 0.3) {
            self.menuVC.view.frame = CGRect(x:0, y:60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.addChildViewController(self.menuVC)
            self.view.addSubview(self.menuVC.view)
            AppDelegate.isMenuVC = false
        }
    }
    
    func hideMenu(){
        UIView.animate(withDuration: 0.3, animations: {
            self.menuVC.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y:60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            
        }) { (finished) in
            self.menuVC.view.removeFromSuperview()
            AppDelegate.isMenuVC = true
        }
        
        
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