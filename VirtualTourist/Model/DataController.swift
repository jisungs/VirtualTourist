//
//  DataController.swift
//  VirtualTourist
//
//  Created by The book on 2018. 6. 19..
//  Copyright © 2018년 The book. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    let persistentContainer:NSPersistentContainer
    
    init(modelName:String){
        persistentContainer = NSPersistentContainer(name: modelName)
    }
    
    var viewContext:NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func load(completion: (()->Void)? = nil){
        persistentContainer.loadPersistentStores { storeDescription, error in
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
}
