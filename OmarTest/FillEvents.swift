//
//  FillEvents.swift
//  OmarTest
//
//  Created by Richard Rei-Chi Xu on 4/12/15.
//  Copyright (c) 2015 Richard Rei-Chi Xu. All rights reserved.
//

import Foundation
import Parse
import UIKit
import MapKit

class FillEvents : UIViewController {
    
    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myName: UILabel!
    @IBOutlet var myDescrip: UITextView!
    @IBOutlet weak var mapView: MKMapView!
    
    var myLocation = CLLocation(latitude: 37.875715,longitude: -122.259048)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var predicates = [NSPredicate]()
        var predicate = NSPredicate(format: "%K > %@", "latitude", myLocation.coordinate.latitude - 1 as NSObject)
        predicates.append(predicate!)
        predicate = NSPredicate(format: "%K < %@", "latitude", myLocation.coordinate.latitude + 1 as NSObject)
        predicates.append(predicate!)
        predicate = NSPredicate(format: "%K > %@", "longitude", myLocation.coordinate.longitude - 1 as NSObject)
        predicates.append(predicate!)
        predicate = NSPredicate(format: "%K < %@", "longitude", myLocation.coordinate.longitude + 1 as NSObject)
        predicates.append(predicate!)
    
        
        
//        let southPredicate = NSPredicate(format:"latitude < 10 + myLocation.latitude")
//        let northPredicate = NSPredicate(format:"latitude > myLocation.latitude - 10")
//        let eastPredicate = NSPredicate(format:"longitude < 10 + myLocation.longitude")
//        let westPredicate = NSPredicate(format:"longitude < myLocation.longitude - 10")
//        let finalPred = andPredicateWithSubpredicates([southPredicate,northPredicate,eastPredicate,westPredicate])
        var compundPredicate = NSCompoundPredicate.andPredicateWithSubpredicates(predicates)
        
        var query = PFQuery(className:"event", predicate: compundPredicate)
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // Do something with the found objects
                if let objects = objects as? [PFObject] {
                    for object in objects {
                        println(object.objectForKey("name"))

                    }
                }
            } else {
                // Log details of the failure
                println("Error: \(error) \(error.userInfo!)")
            }
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}