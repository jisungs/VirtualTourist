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
    
    let model : NSManagedObjectModel
    let coordinator : NSPersistentStoreCoordinator
    let persistentContext : NSManagedObjectContext
    let persistentContainer:NSPersistentContainer
    let context : NSManagedObjectContext
    
    init(modelName:String){
        persistentContainer = NSPersistentContainer(name: modelName)
        context  = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        
        
        coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        persistentContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        persistentContext.persistentStoreCoordinator = coordinator
        context.parent = persistentContext
        
        return Pin
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
    
   static func shared() -> DataController {
        struct Singleton {
           static var shared = DataController(modelName: "VirtualTourist")
        }
        return Singleton.shared
    }
}
