//
//  Photo.swift
//  VirtualTourist
//
//  Created by The book on 2018. 7. 8..
//  Copyright © 2018년 The book. All rights reserved.
//

import Foundation
import CoreData

@objc(Photo)
public class Photoc: NSManagedObject {
    
    static let name = "Photo"
    
    public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }
    
    public var image: NSData?
    public var title: String?
    public var imageUrl: String?
    public var pin: Pin?
    
    convenience init(title: String, imageUrl: String, forPin: Pin, context: NSManagedObjectContext) {
        if let ent = NSEntityDescription.entity(forEntityName: Photoc.name, in: context) {
            self.init(entity: ent, insertInto: context)
            self.title = title
            self.image = nil
            self.imageUrl = imageUrl
            self.pin = forPin
        } else {
            fatalError("Unable to find Entity name!")
        }
    }
    
}
