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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
    }
    
    func mapView(_ mapView: MKMapView, annotationView view:MKAnnotationView) {
    }
}
