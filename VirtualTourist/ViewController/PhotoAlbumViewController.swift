//
//  PhotoAlbumViewController.swift
//  VirtualTourist
//
//  Created by The book on 2018. 7. 6..
//  Copyright © 2018년 The book. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class PhotoAlbumViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var button: UIBarButtonItem!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
}
