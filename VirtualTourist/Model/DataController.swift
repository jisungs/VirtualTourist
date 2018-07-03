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
    let backgroundContext:NSManagedObjectContext
    let context : NSManagedObjectContext
    let fileManager = FileManager.default
    
    class func sharedInstance() -> DataController {
        struct Singleton {
            static let sharedInstance = DataController(modelName: "VirtualTourist")!
        }
        return Singleton.sharedInstance
    }
    
    
    init?(modelName: String){
        
 
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
        
        context = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        context.parent = persistentContext
        
        backgroundContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroundContext.parent = context
        
        let fileManager = FileManager.default
        
        func addStoreCoordinator(){
            
        }
        
        func fetchPin(_ predicate: NSPredicate, entityName: String, sorting: NSSortDescriptor? = nil) throws -> Pin? {
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
        
        func fetchAllPins(_ predicate: NSPredicate? = nil, entityName: String, sorting: NSSortDescriptor? = nil) throws -> [Pin]? {
            let fr = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
            fr.predicate = predicate
            if let sorting = sorting {
                fr.sortDescriptors = [sorting]
            }
            guard let pin = try context.fetch(fr) as? [Pin] else {
                return nil
            }
            return pin
        }
    }
    
    
   
}

extension DataController {
    
    func saveContext() throws {
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
    
    func autoSave(_ delayInSeconds : Int) {
        
        if delayInSeconds > 0 {
            do {
                try saveContext()
                print("Autosaving")
            } catch {
                print("Error while autosaving")
            }
            
            let delayInNanoSeconds = UInt64(delayInSeconds) * NSEC_PER_SEC
            let time = DispatchTime.now() + Double(Int64(delayInNanoSeconds)) / Double(NSEC_PER_SEC)
            
            DispatchQueue.main.asyncAfter(deadline: time) {
                self.autoSave(delayInSeconds)
            }
        }
    }
}

