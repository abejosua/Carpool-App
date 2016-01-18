//
//  ViewController.swift
//  Carpool
//
//  Created by abe on 10/1/15.
//  Copyright © 2015 abe. All rights reserved.
//

import UIKit

class SignUpController: UIViewController {
    
    @IBOutlet weak var first_name: UITextField!
    @IBOutlet weak var last_name: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        super.touchesBegan(touches, withEvent: event)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignUpNewUser(sender: AnyObject) {
        // prepare json data
        if let firstName = self.first_name.text, lastName = self.last_name.text, let email = self.email.text, username = self.username.text, password = self.password.text{
            
            makeSignUpRequest(firstName, lastName: lastName, username: username, email: email, password: password)
        }
    }
    
    func makeSignUpRequest(firstName: String, lastName:String, username:String, email:String, password:String) {
        
        let mapDict = ["first_name": "\(firstName)", "last_name": "\(lastName)", "username": "\(username)", "email": "\(email)", "password": "\(password)", "password_confirmation": "\(password)"]
        
        let json = ["user" : mapDict ]
        let jsonData = try? NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
        
        // create post request
        let url = NSURL(string: "https://carpool-humanoid-staging.herokuapp.com/users.json")!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.HTTPBody = jsonData
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data,response,error in
            
            if let responseJSON = try? NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String:AnyObject]{
                print(responseJSON)
            }
            if let httpResponse = response as? NSHTTPURLResponse {
                switch(httpResponse.statusCode) {
                case 200: //success
                    print(httpResponse.statusCode)
                    dispatch_async(dispatch_get_main_queue()) {
                        self.performSegueWithIdentifier("signupsegue", sender: self)
                    }
                default:
                    print("GET Request unsuccessful. HTTP Status Code: \(httpResponse.statusCode)")
                    dispatch_async(dispatch_get_main_queue()) {
                        self.displayAlert("Fill all the fields correctly!")
                    }
                }
            } else {
                print("Not a valid http response. NetworkOperation:downloadJSONFromURL()")
                dispatch_async(dispatch_get_main_queue()) {
                    self.displayAlert("Server is down")
                }
            }
        }
        
        task.resume()
    }
    
    private func displayAlert(alert: String) {
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Sign Up Failed!"
        alertView.message = alert
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.show()
    }
    
}

