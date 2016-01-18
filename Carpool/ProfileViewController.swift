//
//  ProfileViewController.swift
//  Carpool
//
//  Created by abe on 10/10/15.
//  Copyright © 2015 abe. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {


    @IBOutlet weak var username: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        username.text = "Welcome " + user.username + "!"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func logOut(sender: AnyObject) {
        is_active = false
        self.performSegueWithIdentifier("logoutsegue", sender: self)
    }
}
