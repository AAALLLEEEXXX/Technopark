//
//  SecondController.swift
//  WhatToday
//
//  Created by Алексей on 13.10.17.
//  Copyright © 2017 Алексей и Игорь. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import SafariServices


class SecondController: UIViewController, UITableViewDelegate {
    
    var realm: Realm!
    var notificationToken: NotificationToken?
    var event = List<EventDB>()
    var realevents: Results<EventDB>?
    
    @IBOutlet weak var tableView: UITableView!
    var dayForSearch: String?
    var monthForSearch: String?

    override func viewDidLoad() {
    super.viewDidLoad()
       tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
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
                
                self.realevents = self.realm.objects(EventDB.self).filter("dataMonth = '\(self.monthForSearch ?? "0")' && dataDay = '\(self.dayForSearch ?? "0")'")
        
                self.notificationToken = self.realevents?.observe { _ in
                   self.updateRemindersList()
                }
             
            })

    }

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

extension SecondController: UITableViewDataSource{
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
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
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


