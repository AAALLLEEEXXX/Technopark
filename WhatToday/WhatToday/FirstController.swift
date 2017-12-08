//
//  FirstController.swift
//  WhatToday
//
//  Created by Алексей on 14.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import UserNotifications

class FirstController: UIViewController {
    
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!

    
    @IBAction func sendNotification(sender: UIButton) {
        scheduleNotification(inSeconds: 5) { (success) in
            if success {
                print("we send it")
            } else{
                print("Failed")
            }
        }
    }
    
  var menuVC: MenuViewController!
    
    
    func scheduleNotification(inSeconds seconds: TimeInterval, completion: (Bool) ->()){
        
        remuveNotifications(withIdentifiers: ["MyUniqueIdentifier"])
        
        let date = Date(timeIntervalSinceNow: seconds)
        print(Data())
        print(date)
        
        let content = UNMutableNotificationContent()
        content.title = "Посмотрите сегодняшние события"
        content.body = "Сегодня в подборке событий мы вам представим....."
        content.sound = UNNotificationSound.default()
        
        let calendar = Calendar(identifier: .gregorian)
        let components = calendar.dateComponents([.month, .day, .hour, .minute, .second], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
        let request = UNNotificationRequest(identifier: "MyUniqueIdentifier", content: content, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request, withCompletionHandler: nil)
        
    }
    
    func remuveNotifications(withIdentifiers identifiers: [String]) {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: identifiers)
    }
    
    deinit {
        remuveNotifications(withIdentifiers: ["MyUniqueIdentifier"])
    }
    
    
    
    
override func viewDidLoad() {
    super.viewDidLoad()
    print(Realm.Configuration.defaultConfiguration.fileURL!)
    
    
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
