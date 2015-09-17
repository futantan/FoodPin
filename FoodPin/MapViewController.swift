//
//  MapViewController.swift
//  FoodPin
//
//  Created by luckytantanfu on 9/17/15.
//  Copyright (c) 2015 futantan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
  @IBOutlet weak var mapView: MKMapView!
  var restaurant: Restaurant!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.mapView.delegate = self
    
    let geoCoder = CLGeocoder()
    geoCoder.geocodeAddressString(restaurant.location, completionHandler: {
      placemarks, error in
      if error != nil {
        println(error)
        return
      }
      
      if placemarks != nil && placemarks.count > 0 {
        let placemark = placemarks[0] as! CLPlacemark
        
        let annotation = MKPointAnnotation()
        annotation.title = self.restaurant.name
        annotation.subtitle = self.restaurant.type
        annotation.coordinate = placemark.location.coordinate
        
        self.mapView.showAnnotations([annotation], animated: true)
        self.mapView.selectAnnotation(annotation, animated: true)
      }
    })
  }
  
  func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
    let identifier = "MyPin"
    
    // to display location using a blue dot
    if annotation.isKindOfClass(MKUserLocation) {
      return nil
    }
    
    var annotionView = mapView.dequeueReusableAnnotationViewWithIdentifier(identifier)
    if annotionView == nil {
      annotionView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
      annotionView.canShowCallout = true
    }
    
    let leftIconView = UIImageView(frame: CGRectMake(0, 0, 53, 53))
    leftIconView.image = UIImage(named: restaurant.imageName)
    annotionView.leftCalloutAccessoryView = leftIconView
    
    return annotionView
  }
}
