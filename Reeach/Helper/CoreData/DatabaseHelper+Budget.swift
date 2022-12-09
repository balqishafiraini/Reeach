//
//  DatabaseHelper+Budget.swift
//  Reeach
//
//  Created by William Chrisandy on 13/10/22.
//

import CoreData

extension DatabaseHelper {
    
    func filterInvalidBudgets(_ budgets: [Budget]) -> [Budget] {
        var result: [Budget] = []
        for budget in budgets {
            if budget.monthlyAllocation <= 0 {
                continue
            }
            else if let goal = budget.category as? Goal,
                    let period = budget.period,
                    let createdAt = goal.createdAt,
                    period < DateFormatHelper.getStartDateOfMonth(of: createdAt) {
                continue
            }
            result.append(budget)
        }
        
        return result
    }
    
    func copyBudgets(_ budgets: [Budget], to period: Date) -> [Budget] {
        var result: [Budget] = []
        for budget in budgets {
            result.append(createBudget(monthlyAllocation: budget.monthlyAllocation, period: period, category: budget.category!))
        }
        return result
    }
    
    func getBudgets() -> [Budget] {
        do {
            let fetchRequest: NSFetchRequest<Budget> = Budget.fetchRequest()
            return filterInvalidBudgets(try context.fetch(fetchRequest))
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
            return filterInvalidBudgets(try context.fetch(fetchRequest))
        }
        catch let error {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
            return []
        }
    }
    
    func getExpenseBudgets(on month: Date) -> [Budget] {
        var result: [Budget] = getBudgets(on: month, type: "Need")
        result.append(contentsOf: getBudgets(on: month, type: "Want"))
        return result.sorted { $0.allocatedRatio > $1.allocatedRatio }
    }
    
    func getBudgets(type: String) -> [Budget] {
        do {
            let fetchRequest: NSFetchRequest<Budget> = Budget.fetchRequest(with: type)
            return filterInvalidBudgets(try context.fetch(fetchRequest))
        }
        catch let error {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
            return []
        }
    }
    
    func getBudgets(on month: Date, type: String) -> [Budget] {
        let date = DateFormatHelper.getStartDateOfMonth(of: month)
        do {
            let fetchRequest: NSFetchRequest<Budget> = Budget.fetchRequest(on: date, with: type)
            return filterInvalidBudgets(try context.fetch(fetchRequest))
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
            return filterInvalidBudgets(try context.fetch(fetchRequest))
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
