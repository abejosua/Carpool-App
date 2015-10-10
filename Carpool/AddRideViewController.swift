//
//  AddRideViewController.swift
//  Carpool
//
//  Created by abe on 10/1/15.
//  Copyright © 2015 abe. All rights reserved.
//

import UIKit

class AddRideViewController: UIViewController {
    
    
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var pickupLocation: UITextField!
    @IBOutlet weak var time: UITextField!
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        if (location.text == "" || pickupLocation.text == "" || time.text == "") {
            let alert = UIAlertController(title: "Alert", message: "Fill all the fields!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            self.performSegueWithIdentifier("submitAddRideSegue", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "submitAddRideSegue" {
            let navigationViewController = segue.destinationViewController as! UINavigationController
            let destinationViewController = navigationViewController.viewControllers.first as! RideTableViewController
            
            destinationViewController.newRide = Ride(id: destinationViewController.rides.count, location: location.text!, pickupLocation: pickupLocation.text!, time: time.text!)
        }
    }
    
}

