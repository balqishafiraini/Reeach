//
//  DatabaseHelper+Budget.swift
//  Reeach
//
//  Created by William Chrisandy on 13/10/22.
//

import CoreData

extension DatabaseHelper {
    func getBudgets() -> [Budget] {
        do {
            let fetchRequest: NSFetchRequest<Budget> = Budget.fetchRequest()
            return try context.fetch(fetchRequest)
        }
        catch let error {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
            return []
        }
    }
    
    func getBudgets(on month: Date) -> [Budget] {
        let date = DateFormatHelper.getStartDateOfMonth(of: month)
        do {
            let fetchRequest: NSFetchRequest<Budget> = Budget.fetchRequest(on: date)
            return try context.fetch(fetchRequest)
        }
        catch let error {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
            return []
        }
    }
    
    func getBudgets(of category: Category) -> [Budget] {
        do {
            let fetchRequest: NSFetchRequest<Budget> = Budget.fetchRequest(of: category.name ?? "")
            return try context.fetch(fetchRequest)
        }
        catch let error {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
            return []
        }
    }
    
    func getBudget(on month: Date, of category: Category) -> Budget? {
        let date = DateFormatHelper.getStartDateOfMonth(of: month)
        do {
            let fetchRequest: NSFetchRequest<Budget> = Budget.fetchRequest(on: date, of: category.name ?? "")
            let result = try context.fetch(fetchRequest)
            return result.isEmpty == true ? nil : result[0]
        }
        catch let error {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
            return nil
        }
    }
    
    func createBudget(monthlyAllocation: Double, period: Date, category: Category) -> Budget {
        let month = DateFormatHelper.getStartDateOfMonth(of: period)
        
        if let budget = getBudget(on: month, of: category) {
            return budget
        }
        else {
            let budget = Budget(context: context)
            budget.monthlyAllocation = monthlyAllocation
            budget.period = month
            budget.category = category
            
            return insert(budget)
        }
    }
}
