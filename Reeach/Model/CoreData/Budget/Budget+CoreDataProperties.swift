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

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Budget> {
        return NSFetchRequest<Budget>(entityName: "Budget")
    }

    @NSManaged public var category: String?
    @NSManaged public var icon: String?
    @NSManaged public var monthlyAllocation: Double
    @NSManaged public var name: String?
    @NSManaged public var transactions: NSSet?

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
