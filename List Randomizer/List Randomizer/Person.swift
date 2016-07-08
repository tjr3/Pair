//
//  Person.swift
//  List Randomizer
//
//  Created by Tyler on 7/8/16.
//  Copyright © 2016 Tyler. All rights reserved.
//

import Foundation
import CoreData


class Person: NSManagedObject {

    convenience init?(name: String, context: NSManagedObjectContext = Stack.sharedStack.managedObjectContext) {
        
        guard let entity = NSEntityDescription.entityForName("Person", inManagedObjectContext: context) else {return nil}
        
        self.init(entity: entity, insertIntoManagedObjectContext: context)
        
        self.name = name
        
    }
}
