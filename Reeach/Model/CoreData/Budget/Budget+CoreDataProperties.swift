//
//  Budget+CoreDataProperties.swift
//  Reeach
//
//  Created by William Chrisandy on 15/10/22.
//
//

import Foundation
import CoreData


extension Budget {
    static let sortDescriptors = [NSSortDescriptor(keyPath: \Budget.period, ascending: false)]

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Budget> {
        let fetchRequest = NSFetchRequest<Budget>(entityName: "Budget")
        fetchRequest.sortDescriptors = sortDescriptors
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(on month: Date) -> NSFetchRequest<Budget>
    {
        let fetchRequest = NSFetchRequest<Budget>(entityName: "Budget")
        fetchRequest.predicate = NSPredicate(format: "period == %@", month as NSDate)
        fetchRequest.sortDescriptors = sortDescriptors
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(of category: String) -> NSFetchRequest<Budget>
    {
        let fetchRequest = NSFetchRequest<Budget>(entityName: "Budget")
        fetchRequest.predicate = NSPredicate(format: "category.name like [c] %@", category)
        fetchRequest.sortDescriptors = sortDescriptors
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(on month: Date, of category: String) -> NSFetchRequest<Budget>
    {
        let fetchRequest = NSFetchRequest<Budget>(entityName: "Budget")
        fetchRequest.predicate = NSPredicate(format: "period == %@ and category.name like [c] %@", month as NSDate, category)
        fetchRequest.sortDescriptors = sortDescriptors
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(on month: Date, with term: String) -> NSFetchRequest<Budget>
    {
        let fetchRequest = NSFetchRequest<Budget>(entityName: "Budget")
        fetchRequest.predicate = NSPredicate(format: "period == %@ and category.term like [c] %@", month as NSDate, term)
        fetchRequest.sortDescriptors = sortDescriptors
        return fetchRequest
    }
    
    @NSManaged public var monthlyAllocation: Double
    @NSManaged public var period: Date?
    @NSManaged public var transactions: NSSet?
    @NSManaged public var category: Category?

}

// MARK: Generated accessors for transactions
extension Budget {

    @objc(addTransactionsObject:)
    @NSManaged public func addToTransactions(_ value: Transaction)

    @objc(removeTransactionsObject:)
    @NSManaged public func removeFromTransactions(_ value: Transaction)

    @objc(addTransactions:)
    @NSManaged public func addToTransactions(_ values: NSSet)

    @objc(removeTransactions:)
    @NSManaged public func removeFromTransactions(_ values: NSSet)

}

extension Budget: Identifiable {
    
}
