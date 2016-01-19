//
//  AddRideViewController.swift
//  Carpool
//
//  Created by abe on 10/1/15.
//  Copyright © 2015 abe. All rights reserved.
//

import UIKit

class AddRideViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    
    @IBOutlet weak var location: UITextField!
    @IBOutlet weak var timePicker: UIDatePicker!
    @IBOutlet weak var pickupLocationPicker: UIPickerView!
    @IBOutlet weak var daySegment: UISegmentedControl!

    var today = true
    
    let pickupLocationData = ["Flagpole","Mustang Garage","HTSC","Loyd Commons"]
    
    @IBAction func submitButtonPressed(sender: AnyObject) {
        if (location.text == "") {
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
        pickupLocationPicker.delegate = self
        pickupLocationPicker.dataSource = self
        let currentDate = NSDate()
        timePicker.minimumDate = currentDate
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickupLocationData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        print(pickupLocationData[row])
        return pickupLocationData[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
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
            
            let strPickupLocation = pickupLocationData[pickupLocationPicker.selectedRowInComponent(0)]
            destinationViewController.newRide = Ride(id: destinationViewController.rides.count, location: location.text!, pickupLocation: strPickupLocation, time: strDate)
        }
    }
    
}

