//
//  Goal+CoreDataClass.swift
//  Reeach
//
//  Created by William Chrisandy on 15/10/22.
//
//

import Foundation
import CoreData

@objc(Goal)
public class Goal: Category {
    func isAchievable(of budget: Budget) -> Bool {
        guard budget.category == self
        else { return false }
        
        return futureValue(from: budget.period ?? Date()) <= expectedSaving(of: budget) ?? 0
    }
    
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
    
    func initialSaving(before month: Date) -> Double {
        var result = 0.0
        let month = DateFormatHelper.getStartDateOfMonth(of: month)
        let budgets = budgets?.allObjects as! [Budget]
        
        for budget in budgets {
            let budgetMonth = budget.period ?? Date()
            if budgetMonth < month {
                let transactions = budget.transactions?.allObjects as! [Transaction]
                
                for transaction in transactions {
                    result += transaction.amount
                }
            }
        }
        return result
    }
    
    func valueAfterInflation(from month:Date) -> Double {
        let inflationRate = UserDefaults.standard.double(forKey: UserDefaultEnum().inflationRate)
        let dd = DateFormatHelper.getMonthDifferences(between: month, and: dueDate ?? Date()) + 1
        
        return targetAmount * pow((1+inflationRate), Double(dd))
    }
    
    func futureValue(from month: Date) -> Double {
        valueAfterInflation(from: month) - initialSaving(before: month)
    }
    
    func expectedSaving(of budget: Budget) -> Double? {
        guard budget.category == self
        else { return nil }
        
        let dd = DateFormatHelper.getMonthDifferences(between: budget.period ?? Date(), and: dueDate ?? Date()) + 1
        return budget.monthlyAllocation * Double(dd)
    }
    
    func targetAmount(of budget: Budget) -> Double? {
        guard budget.category == self
        else { return nil }
        
        if isAchievable(of: budget) {
            return targetAmount
        }
        else {
            let inflationRate = UserDefaults.standard.double(forKey: UserDefaultEnum().inflationRate)
            let month = budget.period ?? Date()
            let dd = DateFormatHelper.getMonthDifferences(between: month, and: dueDate ?? Date()) + 1
            
            return (expectedSaving(of: budget) ?? 0 + initialSaving(before: month)) * pow((1+inflationRate), Double(-dd))
        }
    }
    
    func remaining(of budget: Budget) -> Double? {
        guard budget.category == self
        else { return nil }
        
        return futureValue(from: budget.period ?? Date()) - (expectedSaving(of: budget) ?? 0)
    }
    
    func add(of budget: Budget) -> Double? {
        guard budget.category == self
        else { return nil }
        
        if isAchievable(of: budget) {
            return 0
        }
        else {
            let dd = DateFormatHelper.getMonthDifferences(between: budget.period ?? Date(), and: dueDate ?? Date()) + 1
            
            return (remaining(of: budget) ?? 0) / Double (dd)
        }
    }
    
    func adjustedDeadline(of budget: Budget) -> Date? {
        // TODO: Change this one with Lambert's Function
        
        let expectedSaving = expectedSaving(of: budget) ?? 0
        let month = budget.period ?? Date()
        let initialSaving = initialSaving(before: month)
        let inflationRate = UserDefaults.standard.double(forKey: UserDefaultEnum().inflationRate)
        
        for ad in 0...1200 {
            let saving = expectedSaving * Double(ad) + initialSaving
            let increasedValue = targetAmount * pow((1+inflationRate), Double(ad))
            
            if saving >= increasedValue {
                let currentMonth = DateFormatHelper.getStartDateOfMonth(of: month)
                return Calendar.current.date(byAdding: .month, value: ad, to: currentMonth)
            }
        }
        return nil
    }
}
