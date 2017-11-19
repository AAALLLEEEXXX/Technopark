//
//  Massiv.swift
//  WhatToday
//
//  Created by Алексей on 13.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

import Foundation

struct Massiv {
    let name: String
    let flickrID: String
    
    init(name: String, flickrID: String) {
        self.name = name
        self.flickrID = flickrID
    }
}

extension Massiv: CustomStringConvertible{
    var description: String{
        return "\(name): flickr.com/\(flickrID)"
    }
    
}
