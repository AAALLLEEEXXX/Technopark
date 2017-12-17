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
import SafariServices

class FirstController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var menuBarButtonItem: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    var realm: Realm! //= try! Realm(configuration: configuration)
    var realevents: Results<EventDB>?
    var notificationToken: NotificationToken?
    var event = List<EventDB>()
    
    @IBAction func sendNotification(sender: UIButton) {
        scheduleNotification(inSeconds: 5) { (success) in
            if success {
                print("we send it")
            } else{
                print("Failed")
            }
        }
    }
    
 
    
    
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
    
    //NSDATA
    
    let dateMonthFormatter = DateFormatter()
    dateMonthFormatter.locale = Locale(identifier: "ru_RU")
    dateMonthFormatter.dateFormat = "LLLL"
    let monthForSearch = dateMonthFormatter.string(from: Date()).capFirstLetter()
    
    let dateDayFormatter = DateFormatter()
    dateDayFormatter.dateFormat = "dd"
    let dayForSearch = dateDayFormatter.string(from: Date())
    
    //new code

    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell1")
    SyncUser.logIn(with: .usernamePassword(username: "aaallleeexxx918@gmail.com", password: "aaallleeexxx918", register: false), server: URL(string: "http://127.0.0.1:9080")!) { user, error in
        guard let user = user else {
            fatalError(String(describing: error))
        }
        
        let configuration = Realm.Configuration(
            syncConfiguration: SyncConfiguration(user: user, realmURL: URL(string: "realm://127.0.0.1:9080/~/WhatToday")!, enableSSLValidation: false)
        )
        
        self.realm = try! Realm(configuration: configuration)
        
        
        DispatchQueue.main.async(execute: {
            // Open Realm
            
            self.realevents = self.realm.objects(EventDB.self).filter("dataMonth = '\(monthForSearch)' && dataDay = '\(dayForSearch)'")
            
            self.notificationToken = self.realevents?.observe { _ in
                self.updateRemindersList()
            }

        })
    }
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func updateRemindersList(){
        if self.event.realm == nil{
            self.event = self.realm.objects(EventDB.self).reduce(List<EventDB>()) { (list, element) -> List<EventDB> in
                list.append(element)
                return list
            }
            
        }
        self.tableView.reloadData()
    }
}

extension FirstController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realevents?.count ?? 0
    }
    func showTutorial(_ which: Int, link: String) {
        if let url = URL(string: link) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true
            
            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell1")
            else {
                return UITableViewCell()
        }
        let realevent = realevents?[indexPath.row]
        cell.textLabel?.text = realevent?.desc
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let realevent = realevents?[indexPath.row]
        let eventlink = realevent?.link
        showTutorial(indexPath.row, link: eventlink!)
    }
    
}

extension String {
    func capFirstLetter() -> String {
        return prefix(1).uppercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capFirstLetter()
    }
}
