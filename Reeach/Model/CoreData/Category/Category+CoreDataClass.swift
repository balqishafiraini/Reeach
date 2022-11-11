//
//  Category+CoreDataClass.swift
//  Reeach
//
//  Created by William Chrisandy on 19/10/22.
//
//

import Foundation
import CoreData

@objc(Category)
public class Category: NSManagedObject {
    
    func isActive(on month: Date) -> Bool {
        let month = DateFormatHelper.getStartDateOfMonth(of: month)
        let budgets = budgets?.allObjects as! [Budget]
        
        for budget in budgets {
            let budgetMonth = budget.period ?? Date()
            if budgetMonth == month {
                return true
            }
        }
        return false
    }
}
