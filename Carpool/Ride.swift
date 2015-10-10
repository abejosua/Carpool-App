//
//  Ride.swift
//  Carpool
//
//  Created by abe on 10/1/15.
//  Copyright © 2015 abe. All rights reserved.
//

import Foundation

class Ride {
    let id: Int
    let location: String
    let pickupLocation: String
    let time: String
    
    init (id: Int, location: String, pickupLocation: String, time: String) {
        self.id = id
        self.location = location
        self.pickupLocation = pickupLocation
        self.time = time
    }
}