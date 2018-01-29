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
