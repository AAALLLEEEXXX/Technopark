//
//  EventsDB.swift
//  
//
//  Created by Алексей on 10.11.17.
//

import Foundation
import RealmSwift
import UIKit

class EventsDB: Object {
    @objc  dynamic var dataMonth = ""
    @objc  dynamic var dataDay = ""
    @objc  dynamic var desc = ""
    @objc  dynamic var link = ""
    
}
