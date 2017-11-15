//
//  SecondController.swift
//  WhatToday
//
//  Created by Алексей on 13.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

import Foundation
import UIKit

class SecondController: UIViewController, UITableViewDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    let massiv = [
        Massiv(name:"08/01", flickrID: "С космодрома Байконур осуществлен запуск космического коробля Союз ТМ-18"),
        Massiv(name:"08/01", flickrID: "Катастрофа АН-32 в Киншасе"),
        Massiv(name:"08/01", flickrID: "Катастрофа Beechcraft в Шарлотте"),
        Massiv(name:"08/01", flickrID: "Церемония крещения морского суперлайнера"),
    ]

    override func viewDidLoad() {
        super .viewDidLoad()
     
        
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You select \(massiv[indexPath.row])")
    }
  //  let sravndata = ViewController()
   // sravndata.EventsDB.adddata.dataMonth == months_arr
    
}
    


extension SecondController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return massiv.count
    }
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            else {
                return UITableViewCell()
    }
        
        let massivs = massiv[indexPath.row]
        cell.textLabel?.text = massivs.name
        cell.detailTextLabel?.text = massivs.flickrID
        return cell
}
}

