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
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var daySegment: UISegmentedControl!

    var today = true
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        if (location.text == "" || pickupLocation.text == "") {
            let alert = UIAlertController(title: "Alert", message: "Fill all the fields!", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        } else {
            self.performSegueWithIdentifier("submitAddRideSegue", sender: self)
        }
    }
    
    @IBAction func rideDate(sender: AnyObject) {
        let index = sender.selectedSegmentIndex
        today = index == 0
        if today {
            timePicker.datePickerMode = .Time
            let currentDate = NSDate()
            timePicker.date = currentDate
            timePicker.minuteInterval = 5
        }
        else{
            timePicker.datePickerMode = .DateAndTime
            timePicker.minuteInterval = 5
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let currentDate = NSDate()
        timePicker.minimumDate = currentDate
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
            
            let dateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "HH:mm"
            let strDate = dateFormatter.stringFromDate(timePicker.date)
            
            destinationViewController.newRide = Ride(id: destinationViewController.rides.count, location: location.text!, pickupLocation: pickupLocation.text!, time: strDate)
        }
    }
    
}

