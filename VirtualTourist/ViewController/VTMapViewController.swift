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

class VTMapViewController: UIViewController {
  
    //MARK: - Outlets
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var footerView: UIView!
    
    //MARK: - variable
    var annotations = [MKPointAnnotation]()
    var annotationPin : MKPointAnnotation? = nil
    var longPressRecongizer = UILongPressGestureRecognizer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        longPressRecongizers()
        navigationItem.rightBarButtonItem = editButtonItem
        footerView.isHidden = true
    }
    
    @IBAction func longPress(_ sender: UILongPressGestureRecognizer){
        
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
                context: DataController.sharedInstance().context
            )
            save()
        }
        
    }
    
    func longPressRecongizers() {
        longPressRecongizer = UILongPressGestureRecognizer(target: self, action: #selector(longPress))
        longPressRecongizer.minimumPressDuration = 0.5
        longPressRecongizer.delegate = self as? UIGestureRecognizerDelegate
        mapView.addGestureRecognizer(longPressRecongizer)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        footerView.isHidden = !editing
    }
    
    func loadAllPins() -> [Pin]?{
        
        var pins: [Pin]?
        do {
            try pins = DataController.sharedInstance().fetchAllPins(entityName: Pins.name)
        } catch {
            print("\(#function) error:\(error)")
            showAlert(title: "Error", message: "Error while fetching pin")
        }
        return pins
    }
    
    private func loadPin(latitude: String, longitude: String) -> Pin? {
        let predicate = NSPredicate(format: "latitude == %@ AND longitude == %@", latitude, longitude)
        var pin: Pin?
        do {
            try pin = DataController.sharedInstance().fetchPin(predicate, entityName: Pins.name)
        } catch {
            print("\(#function) error:\(error)")
            showAlert(title: "Error", message: "Error while fetching location:\(error)")
        }
        return pin
    }
    
    func showPins(_ pins: [Pin]) {
        for pin in pins where pin.latitude != nil && pin.longitude != nil {
            let annotation = MKPointAnnotation()
            let lat = Double(pin.latitude!)!
            let lon = Double(pin.longitude!)!
            annotation.coordinate = CLLocationCoordinate2DMake(lat, lon)
            mapView.addAnnotation(annotation)
        }
        mapView.showAnnotations(mapView.annotations, animated: true)
    }
}

extension VTMapViewController: MKMapViewDelegate {
    
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
