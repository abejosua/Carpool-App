//
//  ViewController.swift
//  Carpool
//
//  Created by abe on 10/1/15.
//  Copyright © 2015 abe. All rights reserved.
//

import UIKit

var user: User!
var is_active = false

let weburl = "https://carpool-humanoid-staging.herokuapp.com"

class ViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func signUpButtonPressed(sender: AnyObject) {
        if fieldsIsBlank() {
            displayAlert("Fill all the fields correctly!")
        } else {
            if let username = self.username.text, password = self.password.text {
                makeLogInRequest(username, password: password)
            }
        }
    }
    private func fieldsIsBlank() -> Bool {
        if (username.text == "" || password.text == "") {
            return true
        } else {
            return false
        }
        
    }
    
    func makeLogInRequest(username:String, password:String) {
        
        let json = ["username": "\(username)","password": "\(password)"]
        
        let jsonData = try? NSJSONSerialization.dataWithJSONObject(json, options: .PrettyPrinted)
        
        // create post request
        let url = NSURL(string: "https://carpool-humanoid-staging.herokuapp.com/login")!
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        // insert json data to the request
        request.HTTPBody = jsonData
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request){ data,response,error in
            
            if let responseJSON = try? NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? [String:AnyObject]{
                if let jsonDictionary = responseJSON, userDictionary = jsonDictionary["user"] {
                    print(userDictionary)
                    if let fname = userDictionary["first_name"],
                        lname = userDictionary["last_name"],
                        username = userDictionary["username"],
                        email = userDictionary["email"],
                        id = userDictionary["id"]{
                            user = User(fname: fname as! String, lname: lname as! String, username: username as! String, email: email as! String)
                            user.id = id as! Int
                    }
                }
            }
            if let httpResponse = response as? NSHTTPURLResponse {
                switch(httpResponse.statusCode) {
                case 200: //success
                    print(httpResponse.statusCode)
                    dispatch_async(dispatch_get_main_queue()) {
                        is_active = true
                        self.performSegueWithIdentifier("logInSegue", sender: self)
                    }
                default:
                    print("GET Request unsuccessful. HTTP Status Code: \(httpResponse.statusCode)")
                    dispatch_async(dispatch_get_main_queue()) {
                        self.displayAlert("Username and Password doesn't match")
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
        let alert = UIAlertController(title: "Alert", message: alert, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "logInSegue") {
        }
    }
    
    


}

