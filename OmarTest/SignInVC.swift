//
//  SignInVC.swift
//  OmarTest
//
//  Created by Richard Rei-Chi Xu on 4/11/15.
//  Copyright (c) 2015 Richard Rei-Chi Xu. All rights reserved.
//

import Foundation
import Parse
import UIKit

class SignInVC: UIViewController {
    
    @IBOutlet var usrIn: UITextField!
    @IBOutlet var pwdIn: UITextField!
    @IBOutlet var labelIn: UILabel!
    
    @IBAction func loginVerifyButtonIN(sender:AnyObject){
        var userIn = usrIn.text
        var passIn = pwdIn.text
        
        if userIn != "" && passIn != "" {
            self.signin(passIn, usr:userIn)
        } else {
            self.labelIn.text = "All Fields Required"
        }
        
    }
    
    func signin(pwd: String, usr: String){
        PFUser.logInWithUsernameInBackground(usr, password:pwd) {
            (user: PFUser!, error: NSError!) -> Void in
            if user != nil {
                // Do stuff after successful login.
                self.labelIn.text = "Good job"
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("TabBar") as UIViewController
                self.presentViewController(vc, animated: true, completion: nil)
            } else {
                // The login failed. Check error to see why.
                self.labelIn.text = "You done fucked up. Try again"
            }
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
    
    
}
