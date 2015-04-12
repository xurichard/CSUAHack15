//
//  CreateEvent.swift
//  OmarTest
//
//  Created by Richard Rei-Chi Xu on 4/12/15.
//  Copyright (c) 2015 Richard Rei-Chi Xu. All rights reserved.
//

import Foundation
import Parse
import UIKit
import MapKit

class CreateEvent: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myName: UITextField!
    @IBOutlet var myDescrip: UITextView!
    //@IBOutlet var myLocation: UITextField!
    @IBOutlet var LocationDisplay: UILabel!
    
    var coord = CLLocation()
    
    @IBAction func createEvent(sender:AnyObject){
        var descrip = myDescrip.text
        var name = myName.text
        //var picture = UIImage()
        
        var event = PFObject(className:"event")
        event["latitude"] = coord.coordinate.latitude //This is Omar's thing mang <3
        event["longitude"] = coord.coordinate.longitude
        event["name"] = name
        event["description"] = descrip
        event["count"] = 0
        //event["picture"] = picture
        //event["picture"] = picture
                
        event.saveInBackgroundWithBlock {
            (success: Bool, error: NSError!) -> Void in
            if (success) {
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("TabBar") as UIViewController
                self.presentViewController(vc, animated: true, completion: nil)
            } else {
                self.myDescrip.text = "something went wrong mang"
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        var backButton = UIBarButtonItem(title: "sdf", style: .Plain, target: self, action: "goback")
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 20)!], forState: UIControlState.Normal)

        // Do any additional setup after loading the view, typically from a nib.
        LocationDisplay.text = coord.description
        //myLabel.text = myName.text
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
