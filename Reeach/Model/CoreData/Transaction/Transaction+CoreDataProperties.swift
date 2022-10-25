//
//  Transaction+CoreDataProperties.swift
//  Reeach
//
//  Created by William Chrisandy on 15/10/22.
//
//

import Foundation
import CoreData

extension Transaction {
    static let sortDescriptors = [NSSortDescriptor(keyPath: \Transaction.date, ascending: false)]

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Transaction> {
        let fetchRequest = NSFetchRequest<Transaction>(entityName: "Transaction")
        fetchRequest.sortDescriptors = sortDescriptors
        return fetchRequest
    }

    @nonobjc public class func fetchRequest(id: Int) -> NSFetchRequest<Transaction> {
        let fetchRequest = NSFetchRequest<Transaction>(entityName: "Transaction")
        fetchRequest.predicate = NSPredicate(format: "id == %i", id)
        fetchRequest.sortDescriptors = sortDescriptors
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(since: Date, upTo: Date) -> NSFetchRequest<Transaction>
    {
        let fetchRequest = NSFetchRequest<Transaction>(entityName: "Transaction")
        fetchRequest.predicate = NSPredicate(format: "date >= %@ and date < %@", since as NSDate, upTo as NSDate)
        fetchRequest.sortDescriptors = sortDescriptors
        return fetchRequest
    }
    
    @nonobjc public class func fetchRequest(on month: Date, of category: String) -> NSFetchRequest<Transaction>
    {
        let fetchRequest = NSFetchRequest<Transaction>(entityName: "Transaction")
        fetchRequest.predicate = NSPredicate(format: "budget.period == %@ and budget.category.name like [c] %@", month as NSDate, category)
        fetchRequest.sortDescriptors = sortDescriptors
        return fetchRequest
    }
    
    @NSManaged public var amount: Double
    @NSManaged public var date: Date?
    @NSManaged public var id: Int64
    @NSManaged public var notes: String?
    @NSManaged public var transactionName: String?
    @NSManaged public var budget: Budget?

}

extension Transaction: Identifiable, AutoIncrementInt64Id {
    static var keyLastId: String = "transactionLastId"
}
