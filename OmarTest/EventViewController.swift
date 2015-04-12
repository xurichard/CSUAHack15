//
//  EventViewController.swift
//  Checker
//
//  Created by Richard Rei-Chi Xu on 4/12/15.
//  Copyright (c) 2015 Richard Rei-Chi Xu. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import Parse
import MapKit

class EventViewController: UITableViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    
    var event = Event()
    
    var eventsModel = EventModel()
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    let locationManager = CLLocationManager()
    var theEvents = Array<Event>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myLat = appDelegate.theLat
        let myLong = appDelegate.theLong
        
        println(myLat)
        println(myLong)
        
        var predicates = [NSPredicate]()
        var predicate = NSPredicate(format: "%K > %@", "latitude", myLat - 1 as NSObject)
        predicates.append(predicate!)
        predicate = NSPredicate(format: "%K < %@", "latitude", myLat + 1 as NSObject)
        predicates.append(predicate!)
        predicate = NSPredicate(format: "%K > %@", "longitude", myLong - 1 as NSObject)
        predicates.append(predicate!)
        predicate = NSPredicate(format: "%K < %@", "longitude", myLong + 1 as NSObject)
        predicates.append(predicate!)
        
        
        
        //        let southPredicate = NSPredicate(format:"latitude < 10 + myLocation.latitude")
        //        let northPredicate = NSPredicate(format:"latitude > myLocation.latitude - 10")
        //        let eastPredicate = NSPredicate(format:"longitude < 10 + myLocation.longitude")
        //        let westPredicate = NSPredicate(format:"longitude < myLocation.longitude - 10")
        //        let finalPred = andPredicateWithSubpredicates([southPredicate,northPredicate,eastPredicate,westPredicate])
        var list = [Event]()
        
        var compundPredicate = NSCompoundPredicate.andPredicateWithSubpredicates(predicates)
        
        var query = PFQuery(className:"event", predicate: compundPredicate)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        var event = Event()
                        event.eventName = object.objectForKey("name") as String
                        event.eventLat = object.objectForKey("latitude") as Double
                        event.eventLong = object.objectForKey("longitude") as Double
                        event.description = object.objectForKey("description") as String
                        if object.objectForKey("count") != nil{
                            event.count = object.objectForKey("count") as Int
                        }
                        else{
                            event.count = 0
                        }
                        if object.objectForKey("ObjectID") != nil{
                            event.ObjectID = object.objectForKey("ObjectID") as String
                        } else{
                            event.ObjectID = "None"
                        }
                        list.append(event)
                        println(object.objectForKey("name"))
                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }
            self.theEvents = list
            self.tableView.reloadData()
        }
        

        
        eventsModel.listOfEvents = list
        
        //        for event in eventsModel.listOfEvents {
        //            print ("Hello from the viewDidLoad")
        //            print("Comparing \(event.eventLat) to \(theLat) and \(event.eventLong) to \(theLong)")
        //            if event.eventLat == theLat && event.eventLong == theLong {
        //                theEvents.append(event)
        //            }
        //        }
        theEvents = eventsModel.listOfEvents
        
        /*let myButton: UIButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        myButton.addTarget(self, action: "insertCell:", forControlEvents: .TouchUpInside)
        
        var rightItem:UIBarButtonItem = UIBarButtonItem()
        rightItem.customView = myButton
        self.navigationItem.setRightBarButtonItem(rightItem, animated:
        
        
        
        var b = UIBarButtonItem(title: "Continue", style: .Plain, target: self, action:"sayHello:")
        self.navigationItem.rightBarButtonItem = b
        */
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    /*override func viewWillAppear(animated: Bool) {
    self.locationManager.delegate = self
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
    self.locationManager.requestWhenInUseAuthorization()
    self.locationManager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
    CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: { (placemarks, error) -> Void in
    
    if (error != nil) {
    println("Error:" + error.localizedDescription)
    return
    }
    
    if placemarks.count > 0 {
    let pm = placemarks[0] as CLPlacemark
    self.displayLocationInfo(pm)
    } else {
    println("Error with data")
    }
    })
    var location:CLLocation = locations.last as CLLocation
    var eventDate = location.timestamp
    var howRecent = eventDate.timeIntervalSinceNow
    let lat = location.coordinate.latitude
    let long = location.coordinate.longitude
    
    theLat = lat
    theLong = long
    
    print("Lat is \(lat)")
    print("Long is \(long)")
    
    /*if (abs(howRecent) < 15.0) {
    print("Lat is \(location.coordinate.latitude) and  \(location.coordinate.longitude)")
    }*/
    //print("hi")
    /*var location:CLLocation = locations.last as CLLocation
    var eventDate = location.timestamp
    var howRecent = eventDate.timeIntervalSinceNow
    if (abs(howRecent) < 15.0) {
    print("Lat is \(location.coordinate.latitude) and \(location.coordinate.longitude)")
    }*/
    }
    
    
    
    func displayLocationInfo(placemark: CLPlacemark) {
    self.locationManager.stopUpdatingLocation()
    println(placemark.locality)
    println(placemark.postalCode)
    println(placemark.administrativeArea)
    println(placemark.country)
    }
    */
    
    func sayHello(sender: UIBarButtonItem) {
        print ("hello")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.theEvents.count;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        print("We have myLat as: \(appDelegate.theLat) and myLong as: \(appDelegate.theLong) \n")
        
        //if (self.theEvents[indexPath.row].eventLat == appDelegate.theLat && self.theEvents[indexPath.row].eventLong == appDelegate.theLong) {
        var theEventName = self.theEvents[indexPath.row].eventName
        cell.textLabel?.text = self.theEvents[indexPath.row].eventName
        //}
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        performSegueWithIdentifier("mySegue", sender: self)
        
        
        for thing in theEvents{
            if(thing.eventName == self.theEvents[indexPath.row].eventName){
                event = thing
            }
        }
        print("THISSDFKJSDHFKLJHSDF")
        print(event.eventName)
        
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var DestViewController : IndivEventVC = segue.destinationViewController as IndivEventVC
        print(event.description)
        println("hi")
        DestViewController.myText = event.description
        DestViewController.myName = event.eventName
        DestViewController.myLat = event.eventLat
        DestViewController.myLong = event.eventLong
        DestViewController.myCount = event.count
        DestViewController.myID = event.ObjectID
    }
}

