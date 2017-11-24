//
//  EventsDB.swift
//  WhatToday
//
//  Created by Алексей on 08.11.17.
//  Copyright © 2017 Алексей. All rights reserved.
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
