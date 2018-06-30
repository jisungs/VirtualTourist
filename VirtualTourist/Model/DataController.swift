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
    let modelURL:URL
    let coordinator : NSPersistentStoreCoordinator
    let persistentContext : NSManagedObjectContext
    let persistentContainer:NSPersistentContainer
    let backgroundContext:NSManagedObjectContext
    let context : NSManagedObjectContext
    let fileManager = FileManager.default
    
    init?(modelName: String){
        
 
        persistentContainer = NSPersistentContainer(name: modelName)
        context  = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        
        // Assumes the model is in the main bundle
        guard let modelURL = Bundle.main.url(forResource: modelName, withExtension: "momd") else {
            print("Unable to find \(modelName)in the main bundle")
            return nil
        }
        self.modelURL = modelURL
        
        // Try to create the model from the URL
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            print("unable to create a model from \(modelURL)")
            return nil
        }
        self.model = model
        
        coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        persistentContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        persistentContext.persistentStoreCoordinator = coordinator
        context.parent = persistentContext
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.parent = context
        
        
        func addStoreCoordinator(){
            
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
    return Singleton.shared!
    }
}

extension DataController {
    
    func saveContext() {
        context.performAndWait {
            if self.context.hasChanges{
                do {
                    try self.context.save()
                } catch {
                    print("Error while saving context:\(error)")
                }
                
                self.persistentContext.perform() {
                    do {
                        try self.persistentContext.save()
                    }catch {
                        print("Error while saving persisting context:\(error)")
                    }
                }
            }
        }
    }
}

