//
//  MapViewController.swift
//  Play Buddy
//
//  Created by Sai Prakhya Tata on 12/4/16.
//  Copyright © 2016 Soni Mamidi. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class MapViewController: UIViewController ,CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet var map: MKMapView!
    let manager: CLLocationManager = CLLocationManager()
    //var lat : Double = nil
   // var long : Double = nil
    var myLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(0,0)
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 241 / 255.0, green: 248 / 255.0, blue: 233 / 255.0, alpha: 1.0)
     
        self.navigationItem.title = "Maps"
        
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.requestAlwaysAuthorization()
        
        manager.requestLocation()
        
        manager.startUpdatingLocation()
        map.delegate = self
        map.showsUserLocation = true
        
         performSearch()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
        
    {
        
        let location = locations[0]
        
        let span:MKCoordinateSpan = MKCoordinateSpanMake(0.03, 0.03)
        
         self.myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
        
        map.setRegion(region, animated: true)
        
        self.map.showsUserLocation = true
        performSearch()
        
    //    self.lat = myLocation.latitude
       // self.long = myLocation.longitude
        
    }
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("error")
        
    }
    
    
    func performSearch(){
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "stadium"
          request.region = MKCoordinateRegionMakeWithDistance(myLocation, 500, 500)
       // request.region = map.region
        
        
        let search = MKLocalSearch(request: request)
        search.startWithCompletionHandler{
            (response: MKLocalSearchResponse?, error: NSError?) in
            if let items = response? .mapItems
            {
                for item in items{
                    print("Item name = \(item.name)")
                    let title = item.name
                                    let lat =  item.placemark.coordinate.latitude
                                    let  long = item.placemark.coordinate.longitude
                                    let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
                    
                                    let objAnnotation = MKPointAnnotation()
                    
                                    objAnnotation.coordinate = pinLocation
                                    objAnnotation.title = title
                                    self.map.addAnnotation(objAnnotation)

                }
                
            }
//        search.startWithCompletionHandler { (response, error) in
//            guard let response = response else {
//                print("Search error: \(error)")
//                return
            }
            
//            for item in response.mapItems {
//                print("Name = \(item.name)")
//                let title = item.name
//                let lat =  item.placemark.coordinate.latitude
//                let  long = item.placemark.coordinate.longitude
//                let pinLocation : CLLocationCoordinate2D = CLLocationCoordinate2DMake(lat, long)
//                
//                let objAnnotation = MKPointAnnotation()
//                
//                objAnnotation.coordinate = pinLocation
//                objAnnotation.title = title
//                self.map.addAnnotation(objAnnotation)
//                
//                
//            }
        
        }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
}


