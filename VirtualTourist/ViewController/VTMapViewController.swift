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
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer){
        showAlert(title: "long Pressed", message: "long Press succeeded")
        
        
            
    }
    
    //MARK: - variable
    var annotations = [MKPointAnnotation]()
    var pin : MKPointAnnotation? = nil
    var longPressRecongnizer = UILongPressGestureRecognizer()
    
    fileprivate func longPressRecongnizers() {
        longPressRecongnizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        longPressRecongnizer.minimumPressDuration = 0.5
        longPressRecongnizer.delegate = self as? UIGestureRecognizerDelegate
        mapView.addGestureRecognizer(longPressRecongnizer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        longPressRecongnizers()
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
    

    
}
