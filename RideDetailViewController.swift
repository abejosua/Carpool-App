//
//  RideDetail.swift
//  Carpool
//
//  Created by abe on 10/1/15.
//  Copyright © 2015 abe. All rights reserved.
//

import UIKit

class RideDetailViewController: UIViewController {
    
    var ride: Ride?
    
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var pickupLocation: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initRideDisplay(self.ride!)
    }
    
    private func initRideDisplay(ride: Ride) {
        location.text = ride.location
        time.text = ride.time
        pickupLocation.text = ride.pickupLocation
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}