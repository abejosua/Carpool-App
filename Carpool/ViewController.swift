//
//  ViewController.swift
//  Carpool
//
//  Created by abe on 10/1/15.
//  Copyright © 2015 abe. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func signUpButtonPressed(sender: AnyObject) {
        if fieldsIsBlank() {
            displayAlert()
        } else {
            // Proceed
            performSegueWithIdentifier("logInSegue", sender: self)
        }
    }
    private func fieldsIsBlank() -> Bool {
        if (username.text == "" || password.text == "") {
            return true
        } else {
            return false
        }
        
    }
    private func displayAlert() {
        let alert = UIAlertController(title: "Alert", message: "Fill all the fields!", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

