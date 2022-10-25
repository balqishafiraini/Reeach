//
//  Category+CoreDataProperties.swift
//  Reeach
//
//  Created by William Chrisandy on 19/10/22.
//
//

import Foundation
import CoreData


extension Category {
    static let sortDescriptors = [NSSortDescriptor(keyPath: \Category.name, ascending: true)]

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
        fetchRequest.sortDescriptors = sortDescriptors
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(name: String) -> NSFetchRequest<Category> {
        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
        fetchRequest.predicate = NSPredicate(format: "name like [c] %@", name)
        fetchRequest.sortDescriptors = sortDescriptors
        return fetchRequest
    }

    @nonobjc public class func fetchRequest(type: String) -> NSFetchRequest<Category> {
        let fetchRequest = NSFetchRequest<Category>(entityName: "Category")
        fetchRequest.predicate = NSPredicate(format: "type like [c] %@", type)
        fetchRequest.sortDescriptors = sortDescriptors
        return fetchRequest
    }
    
    @NSManaged public var icon: String?
    @NSManaged public var type: String?
    @NSManaged public var name: String?
    @NSManaged public var budgets: NSSet?

}

// MARK: Generated accessors for budgets
extension Category {

    @objc(addBudgetsObject:)
    @NSManaged public func addToBudgets(_ value: Budget)

    @objc(removeBudgetsObject:)
    @NSManaged public func removeFromBudgets(_ value: Budget)

    @objc(addBudgets:)
    @NSManaged public func addToBudgets(_ values: NSSet)

    @objc(removeBudgets:)
    @NSManaged public func removeFromBudgets(_ values: NSSet)

}

extension Category: Identifiable {
    
}
