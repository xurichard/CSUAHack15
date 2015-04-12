//
//  IndivEventVC.swift
//  OmarTest
//
//  Created by Richard Rei-Chi Xu on 4/12/15.
//  Copyright (c) 2015 Richard Rei-Chi Xu. All rights reserved.
//

import Foundation
import Parse
import MapKit

class IndivEventVC: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var displayName: UILabel!
    @IBOutlet var displayDescription: UITextView!
    
    @IBOutlet var displayPlace: UILabel!
    
    var myText = String()
    var myName = String()
    var myLat = Double()
    var myLong = Double()
    var myLocation = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var myCount = Int()
    var myID = String()
    
    @IBAction func Checkin(sender:AnyObject){
        displayPlace.text = String(myCount)
        
        var query = PFQuery(className:"event")
        query.getObjectInBackgroundWithId(myID) {
            (event: PFObject!, error: NSError!) -> Void in
            if error != nil {
                println(error)
            } else {
                event["count"] = self.myCount + 1
                event.saveInBackground()
            }
        }
    }
    
    @IBAction func backButton(sender:AnyObject){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("TabBar") as UIViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        print(myText)
        print(myName)
        displayName.text = myName
        displayDescription.text = myText
        myLocation = CLLocationCoordinate2D(latitude: myLat, longitude: myLong)
        
        
        
        let location = myLocation
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        var anotation = MKPointAnnotation()
        anotation.coordinate = location
        anotation.title = "Event"
        anotation.subtitle = "Is Hurrrr"
        mapView.addAnnotation(anotation)
    }

}