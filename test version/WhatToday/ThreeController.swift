//
//  ThreeController.swift
//  WhatToday
//
//  Created by Алексей on 14.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

import Foundation
import UIKit

class ThreeController: UIViewController, UITableViewDelegate {
    
    

    @IBOutlet weak var tableViewThree: UITableView!
    
    let massivthree = [
        Massiv(name:"", flickrID: "С космодрома Байконур осуществлен запуск космического коробля Союз ТМ-18"),
        Massiv(name:"", flickrID: "Катастрофа АН-32 в Киншасе"),
        Massiv(name:"", flickrID: "Катастрофа Beechcraft в Шарлотте"),
        Massiv(name:"", flickrID: "Церемония крещения морского суперлайнера"),
        ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You select \(massivthree[indexPath.row])")
    }
}
    
    
extension ThreeController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return massivthree.count
    }
    func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewThree.dequeueReusableCell(withIdentifier: "cell")
            else {
                return UITableViewCell()
        }
        
        let massivsthree = massivthree[indexPath.row]
        cell.textLabel?.text = massivsthree.name
        cell.detailTextLabel?.text = massivsthree.flickrID
        return cell
    }
}
