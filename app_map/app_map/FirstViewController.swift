//
//  FirstViewController.swift
//  app_map
//
//  Created by swift on 20/12/14.
//  Copyright (c) 2014 swift. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

var places: [Place] = []
var arrayPlaces: NSMutableArray = []

class FirstViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var Control: UISegmentedControl!
    @IBOutlet weak var map: MKMapView!
    let locationManager = CLLocationManager()
    @IBOutlet weak var segment: UISegmentedControl!
    @IBAction func segment_button(sender: AnyObject) {
        if segment.selectedSegmentIndex == 0
        {
            map.mapType = MKMapType.Standard
        }
        else if segment.selectedSegmentIndex == 1
        {
            map.mapType = MKMapType.Satellite
        }
        else if segment.selectedSegmentIndex == 2
        {
            map.mapType = MKMapType.Hybrid
        }
    }
    //######################  FIRST ZOOM   #############################
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.mapType = MKMapType.Hybrid
        let location = CLLocationCoordinate2D(
            latitude: 48.8965929,
            longitude: 2.3183989
        )
        var centerLocation = CLLocationCoordinate2DMake(48.8965929, 2.3183989)
        let span = MKCoordinateSpanMake(0.0003, 0.0003)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = "Ecole 42"
        annotation.subtitle = "Cybercafé, Hôtel et Cinéma"
        self.map.addAnnotation(annotation)
        
        
        
        // MARK: Plist
        if let path = NSBundle.mainBundle().pathForResource("Place", ofType: "plist"){
            arrayPlaces = NSMutableArray(contentsOfFile: path)!
        }
        createArrayPlaces()
        
    }
    //##################################################################
    
    // ####################    GEOLOCATION    ##########################
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location, completionHandler: {(placemarks, error)->Void in
            
            if (error != nil) {
                println("Reverse geocoder failed with error" + error.localizedDescription)
                return
            }
            
            if placemarks.count > 0 {
                let pm = placemarks[0] as CLPlacemark
                self.displayLocationInfo(pm)
            } else {
                println("Problem with the data received from geocoder")
            }
        })
    }
    
    func displayLocationInfo(placemark: CLPlacemark?) {
        if let containsPlacemark = placemark {
            locationManager.stopUpdatingLocation()
            var annotation2 = MKPointAnnotation()
            map.removeAnnotations(map.annotations)
            let locality = (containsPlacemark.locality != nil) ? containsPlacemark.locality : ""
            let postalCode = (containsPlacemark.postalCode != nil) ? containsPlacemark.postalCode : ""
            let administrativeArea = (containsPlacemark.administrativeArea != nil) ? containsPlacemark.administrativeArea : ""
            let country = (containsPlacemark.country != nil) ? containsPlacemark.country : ""
            println(locality)
            println(postalCode)
            println(administrativeArea)
            println(country)
            var centerLocation2 = CLLocationCoordinate2DMake(containsPlacemark.location.coordinate.latitude, containsPlacemark.location.coordinate.longitude)
            
            var mapSpan2 = MKCoordinateSpanMake(0.003, 0.003)
            
            var mapRegion2 = MKCoordinateRegionMake(centerLocation2, mapSpan2)
            
            self.map.setRegion(mapRegion2, animated: true)
            
            annotation2.coordinate = centerLocation2
            annotation2.title = locality
            annotation2.subtitle = postalCode + " " + administrativeArea + " " + country
            self.map.addAnnotation(annotation2)
        }
    }
    
    func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        println("Error while updating location " + error.localizedDescription)
    }
    
    @IBAction func findMyLocation(sender: UIButton) {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    
    //##################################################################
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Places
    func createArrayPlaces() {
        
        for item in arrayPlaces {
            var aPlace = Place(titlePinAnnotation: item["title"] as String,
                subTitleAnnotation: item["subTitle"] as String,
                latitude: item["lat"] as Double,
                longitude: item["lon"] as Double)
            places.append(aPlace)
        }
    }
}
