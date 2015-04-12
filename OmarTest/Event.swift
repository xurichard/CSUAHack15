//
//  Event.swift
//  OmarTest
//
//  Created by Richard Rei-Chi Xu on 4/12/15.
//  Copyright (c) 2015 Richard Rei-Chi Xu. All rights reserved.
//

import Foundation
import UIKit

import Foundation

class Event {
    var eventName: String
    var eventLat: Double
    var eventLong: Double
    var description: String
    var count : Int
    var ObjectID : String
    
    init() {
        eventLat = 0.0
        eventLong = 0.0
        eventName = "None"
        description = "None"
        count = 0
        ObjectID = "None"
    }
    
    init(name:String, lat:Double, long:Double, descrip:String, ObjectID: String) {
        eventName = name
        eventLat = lat
        eventLong = long
        description = descrip
        count = 0
        self.ObjectID = ObjectID
    }
    
}