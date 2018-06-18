//
//  Pin.swift
//  VirtualTourist
//
//  Created by The book on 2018. 6. 18..
//  Copyright © 2018년 The book. All rights reserved.
//

import Foundation
import CoreData

@objc(Pin)
public class Pin: NSManagedObject {
    
    static let name = "Pin"
    
   convenience init(latitude: String, longitude: String, context: NSManagedObjectContext) {
    if let ent = NSEntityDescription.entity(forEntityName: Pin.name, in: context) {
        self.init(entity: ent, insertInto: context)
        self.latitude = latitude
        self.longitude = longitude
    } else {
        fatalError("Unable to find the name")
      }
    }
    
}

extension Pin {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Pin> {
        return NSFetchRequest<Pin>(entityName: "Pin")
    }
    
    @NSManaged public var latitude: String?
    @NSManaged public var longitude: String?
    @NSManaged public var photos: NSSet?
    
}

