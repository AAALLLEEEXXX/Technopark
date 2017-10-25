//
//  MenuViewController.swift
//  WhatToday
//
//  Created by Алексей on 24.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

import Foundation
import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var menuTableView: UITableView!
    
    let myTitle = ["Помощь", "Информация", "Поддержка"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = menuTableView.dequeueReusableCell(withIdentifier: "MenuCell") as! MenuTableViewCell
        cell.labelText.text = myTitle[indexPath.row]
        return cell
    }
    
    
    
}
