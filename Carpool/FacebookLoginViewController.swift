//
//  ViewController.swift
//  Carpool
//
//  Created by abe on 10/1/15.
//  Copyright © 2015 abe. All rights reserved.
//

import UIKit

class FacebookViewController: UIViewController, FBSDKLoginButtonDelegate {
    
    @IBAction func LoginWithFacebookPressed(sender: FBSDKLoginButton) {
        print("Login With Facebook Pressed")
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (FBSDKAccessToken.currentAccessToken() != nil)
        {
            self.performSegueWithIdentifier("Facebook Login Segue", sender: self)
            // User is already logged in, do work such as go to next view controller.
        }
        else
        {
            let loginView : FBSDKLoginButton = FBSDKLoginButton()
            self.view.addSubview(loginView)
            loginView.center = self.view.center
            loginView.readPermissions = ["public_profile", "email", "user_friends"]
            loginView.delegate = self
        }
    }
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")
        
//        self.performSegueWithIdentifier("Facebook Login Segue", sender: self)
        if ((error) != nil)
        {
            // Process error
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email")
            {
                self.returnUserData()
                self.performSegueWithIdentifier("Facebook Login Segue", sender: self)
                // Do work
            }
        }
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!) {
        print("User Logged Out")
    }
    
    // Here is an extra method to grab the Users Facebook data. You can call this method anytime after a user has logged in by calling self.returnUserData().
    func returnUserData()
    {
        let graphRequest : FBSDKGraphRequest = FBSDKGraphRequest(graphPath: "me", parameters: nil)
        graphRequest.startWithCompletionHandler({ (connection, result, error) -> Void in
            
            if ((error) != nil)
            {
                // Process error
                print("Error: \(error)")
            }
            else
            {
                print("fetched user: \(result)")
                if let userName = result.valueForKey("name"), userEmail = result.valueForKey("email") {
                    print("User Name is: \(userName)")
                    print("User Email is: \(userEmail)")
                }
//                print("User Name is: \(userName)")
//                let userEmail : NSString = result.valueForKey("email") as! NSString
//                print("User Email is: \(userEmail)")
                
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

