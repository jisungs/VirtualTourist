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
    let backgroundContext:NSManagedObjectContext
    let context : NSManagedObjectContext
    let fileManager = FileManager.default
    
    init(modelName: String){
        
 
        persistentContainer = NSPersistentContainer(name: modelName)
        context  = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        self.model = model
        coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        persistentContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        persistentContext.persistentStoreCoordinator = coordinator
        context.parent = persistentContext
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.parent = context
        
        
        func addStoreCoordinator(){
            
        }
        
        func fetchPin(_ predicate: NSPredicate, entityName: String, sorting: NSSortDescriptor? = nil)throws -> Pin? {
            let fr = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            fr.predicate = predicate
            if let sorting = sorting {
                fr.sortDescriptors = [sorting]
            }
            
            guard let pin = (try context.fetch(fr) as! [Pin]).first else {
                return nil
            }
          return pin
        }
        
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
