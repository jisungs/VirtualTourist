//
//  Pin.swift
//  VirtualTourist
//
//  Created by The book on 2018. 6. 27..
//  Copyright © 2018년 The book. All rights reserved.
//

import Foundation
import CoreData

 class Pins: NSManagedObject {
    
    static let name: String = "Pin"
    var latitude: String?
    var longitude: String?
    
    convenience init(latitude: String, longitude: String, context: NSManagedObjectContext) {
        if let entity = NSEntityDescription.entity(forEntityName: Pins.name, in: context) {
            self.init(entity: entity, insertInto: context)
            self.latitude = latitude
            self.longitude = longitude
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
}
