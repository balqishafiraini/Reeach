//
//  Goal+CoreDataProperties.swift
//  Reeach
//
//  Created by William Chrisandy on 15/10/22.
//
//

import Foundation
import CoreData


extension Goal {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Goal> {
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        fetchRequest.sortDescriptors = sortDescriptors
        return fetchRequest
    }

    @nonobjc public class func fetchRequest(name: String) -> NSFetchRequest<Goal> {
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        fetchRequest.predicate = NSPredicate(format: "name like [c] %@", name)
        fetchRequest.sortDescriptors = sortDescriptors
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(timeTerm: String) -> NSFetchRequest<Goal> {
        let fetchRequest = NSFetchRequest<Goal>(entityName: "Goal")
        fetchRequest.predicate = NSPredicate(format: "timeTerm like [c] %@", timeTerm)
        fetchRequest.sortDescriptors = sortDescriptors
        return fetchRequest
    }
    
    @NSManaged public var createdAt: Date?
    @NSManaged public var dueDate: Date?
    @NSManaged public var targetAmount: Double
    @NSManaged public var timeTerm: String?
    @NSManaged public var updatedAt: Date?

}
