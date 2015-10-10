//
//  RideTableViewController.swift
//  Carpool
//
//  Created by abe on 10/1/15.
//  Copyright © 2015 abe. All rights reserved.
//

import UIKit

class RideTableViewController: UITableViewController {
    
    var rides = [Ride]()
    var newRide: Ride?

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampeRides()
    }
    
    @IBAction func addRide(sender: AnyObject) {
    }
    
    func loadSampeRides() {
        rides.append(Ride(id:rides.count, location: "H-Mart", pickupLocation: "Flagpole", time: "8:20AM"))
        rides.append(Ride(id:rides.count, location: "Kroger", pickupLocation: "Mustang Garage", time: "10:20AM"))
        rides.append(Ride(id:rides.count, location: "Ranch Market 99", pickupLocation: "Hughes Trigg Student Center", time: "12:20PM"))
        if let newRide = self.newRide {
            rides.append(newRide)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rides.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "RideTableViewCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RideTableViewCell
        
        let ride = rides[indexPath.row]
        
        cell.location.text = ride.location
        cell.pickupLocation.text = ride.pickupLocation
        cell.time.text = ride.time
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("rideDetailSegue", sender: self)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation
*/
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "rideDetailSegue" {
            let destinationViewController = segue.destinationViewController as! RideDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            destinationViewController.ride = rides[indexPath.row]
        }
    }

}
