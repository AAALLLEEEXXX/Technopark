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


class SecondController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var dayForSearch: String?
    var monthForSearch: String? {
        didSet {
            guard let monthForSearch = self.monthForSearch else {
                return
            }
            
            self.realevents = (try! Realm()).objects(EventsDB.self).filter("dataMonth = '\(monthForSearch)' && dataDay = '\(dayForSearch ?? "0")'")
        }
    }

    override func viewDidLoad() {
    super.viewDidLoad()
    }

    var realevents: Results<EventsDB>?
}

extension SecondController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return realevents?.count ?? 0
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
}


