//
//  CoreDataStack.swift
//  work_3
//
//  Created by Stanislav Belsky on 27.03.2020.
//  Copyright © 2020 Stanislav Belsky. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    let baseName = "work_3"
    
    static let sharedInstance = CoreDataStack()
    
    init(){
        
        print("Init CoreDataStack")
        
        NotificationCenter.default.addObserver(self, selector: #selector(didSaveContext), name: .NSManagedObjectContextDidSave, object: nil)
    }
        
    @objc func didSaveContext(notification: Notification) {
        
        guard let sender = notification.object as? NSManagedObjectContext else { return }
            
        if sender === mainContext {
//            print("Save mainContext")
            backgroudContext.perform {
                self.backgroudContext.mergeChanges(fromContextDidSave: notification)
            }
        }
        
        if sender === backgroudContext {
//            print("Save backgroudContext")
            mainContext.perform {
                self.mainContext.mergeChanges(fromContextDidSave: notification)
            }
        }
            
    }
    
    //MARK: - default Core Data methods
    lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)
        return urls[urls.count-1]
    }()
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = Bundle.main.url(forResource: baseName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("\(baseName).sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            //1
            let storeType = NSSQLiteStoreType //NSInMemoryStoreType
            
            try coordinator.addPersistentStore(ofType: storeType, configurationName: nil, at: url, options: [NSMigratePersistentStoresAutomaticallyOption: true, NSInferMappingModelAutomaticallyOption: true])
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
            abort()
        }
        
        return coordinator
    }()
    
    //MARK: - Contexts
    lazy var mainContext: NSManagedObjectContext = {
        
        let mainContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        return mainContext
    }()
    
    
    lazy var backgroudContext: NSManagedObjectContext = {
        
        let backgroudContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        backgroudContext.persistentStoreCoordinator = self.persistentStoreCoordinator
        
        return backgroudContext
    }()
    
    lazy var childContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.parent = self.mainContext
        
        return managedObjectContext
    }()
    
    //MARK: - Helper Methods
    func clearOldResults() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "MovieItem")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        try! self.persistentStoreCoordinator.execute(deleteRequest, with: mainContext)
        
        self.mainContext.reset()
        
    }
    
}

extension NSManagedObjectContext {
    
    func trySave(complition: (()->())? = nil) {
        
        if self.hasChanges {
            
            do {
                
                try self.save()
                
            } catch {
                let nserror = error as NSError
                NSLog("🐍Unable to save context: unresolved error \(nserror), \(nserror.userInfo)")
                
                abort()
            }

        } else {
            print("❗️Unable to save context: no changes found")
        }
        
        if complition != nil{
            complition!()
        }
        
    }
}

