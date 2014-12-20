//
//  FirstViewController.swift
//  app_map
//
//  Created by swift on 20/12/14.
//  Copyright (c) 2014 swift. All rights reserved.
//

import UIKit
import MapKit

class FirstViewController: UIViewController {

    @IBOutlet weak var Control: UISegmentedControl!
    @IBOutlet weak var map: MKMapView!
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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        map.mapType = MKMapType.Hybrid
        let location = CLLocationCoordinate2D(
            latitude: 48.8965929,
            longitude: 2.3183989
        )
        
        let span = MKCoordinateSpanMake(0.05, 0.05)
        let region = MKCoordinateRegion(center: location, span: span)
        map.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.setCoordinate(location)
        annotation.title = "Ecole 42"
        annotation.subtitle = "Cybercafé, Hôtel et Cinéma"
        map.addAnnotation(annotation)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

//    @IBAction func segment(sender: AnyObject) {
//        if Control.selectedSegmentIndex == 0
//        {
//            map.MkMapType.Standard
//        }
//        else if Control.selectedSegmentIndex == 1
//        {
//            map.MkMapType.Satellite
//        }
//        else Control.selectedSegmentIndex
//        {
//            map.MkMapType.Hybrid
//        }
//    }

}
