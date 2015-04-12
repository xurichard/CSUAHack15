//
//  ViewController.swift
//  OmarTest
//
//  Created by Richard Rei-Chi Xu on 4/11/15.
//  Copyright (c) 2015 Richard Rei-Chi Xu. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {
    
    //Signing up ***********************************************
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var messageLabel: UILabel!
    
    @IBAction func loginVerifyButton(sender: AnyObject) {
        
        var usrEntered = usernameTextField.text
        var pwdEntered = passwordTextField.text
        var emlEntered = emailTextField.text
        
        if usrEntered != "" && pwdEntered != "" && emlEntered != "" {
            self.userSignUp(usrEntered, pass: pwdEntered, mail: emlEntered)
        } else {
            self.messageLabel.text = "All Fields Required"
        }
        
    }
    
    func userSignUp(usr:String, pass:String, mail:String) {
        var user = PFUser()
        user.username = usr
        user.password = pass
        user.email = mail
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool!, error: NSError!) -> Void in
            if error == nil {
                // Hooray! Let them use the app now.
                self.messageLabel.text = "User Signed Up";
            } else {
                // Show the errorString somewhere and let the user try again.
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

