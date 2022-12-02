//
//  Budget+CoreDataClass.swift
//  Reeach
//
//  Created by William Chrisandy on 15/10/22.
//
//

import Foundation
import CoreData

@objc(Budget)
public class Budget: NSManagedObject {
    var allocatedRatio: Double {
        let transactions = transactions?.allObjects as! [Transaction]
        var result = 0.0
        for transaction in transactions {
            result += transaction.amount / monthlyAllocation
        }
        return result
    }
}
