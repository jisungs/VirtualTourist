//
//  VTMapViewController.swift
//  VirtualTourist
//
//  Created by The book on 2018. 6. 16..
//  Copyright © 2018년 The book. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class VTMapViewController: UIViewController, MKMapViewDelegate {
  
    //MARK: - Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBAction func longPress(_ sender : UILongPressGestureRecognizer){
        showAlert(title: "long Pressed", message: "long press succeeded")
    }
    
    //MARK: - variable
    var annotations = [MKPointAnnotation]()
    var pin : AnnotationPin!
    var longPressRecongnizer = UILongPressGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        longPressRecongnizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        longPressRecongnizer.minimumPressDuration = 0.5
        longPressRecongnizer.delegate = self as? UIGestureRecognizerDelegate
        mapView.addGestureRecognizer(longPressRecongnizer)
    
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView  = UIButton(type: .detailDisclosure)
        } else {
          pinView?.annotation = annotation
        }
        return pinView
    }
    
    
    func mapView(_ mapView: MKMapView, annotationView view:MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            showAlert(title: "Error", message: "Failed to connect link")
        }
    }
    
   func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
    
    guard let annotation = view.annotation else{
        return
    }
    let long = String(annotation.coordinate.longitude)
    let lat = String(annotation.coordinate.latitude)
    
    
    }
    
}
