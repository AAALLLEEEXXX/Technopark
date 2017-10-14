//
//  MassivforThree.swift
//  WhatToday
//
//  Created by Алексей on 14.10.17.
//  Copyright © 2017 Алексей. All rights reserved.
//

import Foundation

struct MassivforThree {
    let name: String
    let flickrID: String
    
    init(name: String, flickrID: String) {
        self.name = name
        self.flickrID = flickrID
    }
}

extension MassivforThree: CustomStringConvertible{
    var description: String{
        return "\(name): flickr.com/\(flickrID)"
    }
    
}
