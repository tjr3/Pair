//
//  PersonController.swift
//  List Randomizer
//
//  Created by Tyler on 7/8/16.
//  Copyright © 2016 Tyler. All rights reserved.
//

import Foundation
import CoreData

class PersonController {
    
    static var sharedController = PersonController()
    
    var fetchedResultsController: NSFetchedResultsController
    
    var personArray: [Person] = []
    
    init() {
        let request = NSFetchRequest(entityName: "Person")
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        request.sortDescriptors = [sortDescriptor]
        fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: Stack.sharedStack.managedObjectContext, sectionNameKeyPath: "name", cacheName: nil)
        _ = try? fetchedResultsController.performFetch()
    }
    
    // MARK: - Method Signatures -
    
    func addPerson(name: String) {
        _ = Person(name: name)
        saveContext()
    }
    
    func deletePerson(person: Person) {
        let moc = Stack.sharedStack.managedObjectContext
        moc.deleteObject(person)
        saveContext()
        
    }
    
    // MARK: - Persistence -
    
    func saveContext() {
        do {
            try Stack.sharedStack.managedObjectContext.save()
        } catch {
            print("Error Detected: Failed to save to storage.")
        }
    }
}