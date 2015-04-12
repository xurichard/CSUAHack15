//
//  MapVC.swift
//  OmarTest
//
//  Created by Richard Rei-Chi Xu on 4/12/15.
//  Copyright (c) 2015 Richard Rei-Chi Xu. All rights reserved.
//

import Foundation
import Parse
import UIKit
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var myPlace = CLLocation()
    
//    override init() {
//        let initialLocation = CLLocation(latitude: 37.875715, longitude: -122.259048)
//    }
//    
//    init(lat: Double, long: Double) {
//        let initialLocation = CLLocation(latitude: lat, longitude: long)
//    }
//
//    required init(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
//        // 1
//        let location = CLLocationCoordinate2D(
//            latitude: 37.875715,
//            longitude: -122.259048
//        )
//        
//        // 2
//        let span = MKCoordinateSpanMake(0.05, 0.05)
//        let region = MKCoordinateRegion(center: location, span: span)
//        mapView.setRegion(region, animated: true)
//        
//        //3
//        let annotation = MKPointAnnotation()
//        annotation.setCoordinate(location)
//        annotation.title = "Me"
//        annotation.subtitle = location.latitude.description + " " + location.longitude.description
//        mapView.addAnnotation(annotation)
        
        
        //Back Button
        var backButton = UIBarButtonItem(title: "sdf", style: .Plain, target: self, action: "goback")
        navigationItem.leftBarButtonItem = backButton
        navigationItem.leftBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont(name: "Chalkduster", size: 20)!], forState: UIControlState.Normal)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let location = CLLocationCoordinate2D(
            latitude: 37.875715,
            longitude: -122.259048
        )
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        var anotation = MKPointAnnotation()
        anotation.coordinate = location
        anotation.title = "You"
        anotation.subtitle = "Are here! :D"
        mapView.addAnnotation(anotation)
        
        let longPress = UILongPressGestureRecognizer(target: self, action: "action:")
        longPress.minimumPressDuration = 1.0
        longPress.allowableMovement = 0
        mapView.addGestureRecognizer(longPress)
    }
    
    func action(gestureRecognizer:UIGestureRecognizer) {
        var touchPoint = gestureRecognizer.locationInView(self.mapView)
        var newCoord:CLLocationCoordinate2D = mapView.convertPoint(touchPoint, toCoordinateFromView: self.mapView)
        
        var newAnotation = MKPointAnnotation()
        newAnotation.coordinate = newCoord
        newAnotation.title = "New Location"
        newAnotation.subtitle = "New Subtitle"
        mapView.addAnnotation(newAnotation)
        myPlace = CLLocation(latitude: newCoord.latitude, longitude: newCoord.longitude)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var DestViewController : CreateEvent = segue.destinationViewController as CreateEvent
        DestViewController.coord = myPlace
    }
    
}
