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
    
    func isActive(on date: Date) -> Bool {
        let month = DateFormatHelper.getStartDateOfMonth(of: date)
        let budgets = budgets?.allObjects as! [Budget]
        
        for budget in budgets {
            if let budgetMonth = budget.period,
               budgetMonth == month {
                if budget.monthlyAllocation <= 0 {
                    return false
                }
                else if let goal = self as? Goal,
                   let createdAt = goal.createdAt,
                   budgetMonth < DateFormatHelper.getStartDateOfMonth(of: createdAt)
                {
                    print(#function)
                    return false
                }
                return true
            }
        }
        return false
    }
}
