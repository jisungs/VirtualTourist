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
       // showAlert(title: "long Pressed", message: "long Press succeeded")
        
       let location = sender.location(in: mapView)
        let locCoord = mapView.convert(location, toCoordinateFrom: mapView)
        
        if sender.state == .began {
            annotationPin = MKPointAnnotation()
            annotationPin?.coordinate = locCoord
            
            print("\(#function) Coordinate: \(locCoord.latitude),\(locCoord.longitude)")
            
            mapView.addAnnotation(annotationPin!)
            
        } else if sender.state == .changed {
            annotationPin?.coordinate = locCoord
        } else if sender.state == .ended {
            
            _ = Pins(
                latitude: String(annotationPin!.coordinate.latitude),
                longitude: String(annotationPin!.coordinate.longitude),
                context: DataController.shared().context
            )
            save()
        }
        
    }
    
    //MARK: - variable
    var annotations = [MKPointAnnotation]()
    var annotationPin : MKPointAnnotation? = nil
    var longPressRecongizer = UILongPressGestureRecognizer()
    
    func longPressRecongizers() {
        longPressRecongizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        longPressRecongizer.minimumPressDuration = 0.5
        longPressRecongizer.delegate = self as? UIGestureRecognizerDelegate
        mapView.addGestureRecognizer(longPressRecongizer)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        longPressRecongizers()
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
