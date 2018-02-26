//
//  CoreDataManager.swift
//  Notes
//
//  Created by Perry Davies on 29/01/2018.
//  Copyright © 2018 Perry Davies. All rights reserved.
//

import CoreData
final class CoreDataManager
{
    private let modelName: String!
    
    init(modelName: String)
    {
        self.modelName = modelName
        setupNotificationHandling()
    }
    
    func setupNotificationHandling() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(saveChanges(_:)), name: Notification.Name.UIApplicationWillTerminate , object: nil)
        notificationCenter.addObserver(self, selector: #selector(saveChanges(_:)), name: Notification.Name.UIApplicationWillTerminate , object: nil)
    }
    
    @objc func saveChanges(_ notification:Notification) {
        saveChanges()
    }
    
    func saveChanges() {
        guard managedObjectContext.hasChanges else { return }
        do {
            try managedObjectContext.save()
        } catch {
            // Need to let user know the op has failed...
            print("Unable to save managed object context")
            print("\(error), \(error.localizedDescription)")
        }
    }
    
    private(set) lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        return managedObjectContext
    }()
    
    private lazy var managedObjectModel:NSManagedObjectModel = {
        guard let modelUrl = Bundle.main.url(forResource: modelName, withExtension: "momd")
            else
        {
            fatalError("Fatal error unable to find data model")
        }
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelUrl)
        else
        {
            fatalError("Fatal error unable to find data model")
        }
        return managedObjectModel
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let fileManager = FileManager.default
        let storeName = "\(self.modelName).sqlite"
        var documentDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let persistentStoreURL = documentDirectoryURL.appendingPathComponent(storeName)
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        do
        {
        try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType , configurationName: nil, at: persistentStoreURL, options: nil)
        }
        catch
        {}
        return persistentStoreCoordinator
    }()
    
}
