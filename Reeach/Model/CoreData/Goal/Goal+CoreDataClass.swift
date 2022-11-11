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
        
        return CurrencyHelper.roundUp(targetAmount * pow((1+inflationRate), Double(dd)))
    }
    
    func futureValue(from month: Date) -> Double {
        return valueAfterInflation(from: month) - initialSaving(before: month)
    }
    
    func expectedSaving(of budget: Budget) -> Double? {
        guard budget.category == self
        else { return nil }
        
        let dd = DateFormatHelper.getMonthDifferences(between: budget.period ?? Date(), and: dueDate ?? Date()) + 1
        return CurrencyHelper.roundUp(budget.monthlyAllocation * Double(dd))
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
            
            return CurrencyHelper.roundUp((expectedSaving(of: budget) ?? 0 + initialSaving(before: month)) * pow((1+inflationRate), Double(-dd)))
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
            
            return CurrencyHelper.roundUp((remaining(of: budget) ?? 0) / Double (dd))
        }
    }
    
    func recommendedMonthlyAllocation(of budget: Budget) -> Double? {
        if isAchievable(of: budget) {
            return budget.monthlyAllocation
        }
        else {
            let dd = DateFormatHelper.getMonthDifferences(between: budget.period ?? Date(), and: dueDate ?? Date()) + 1
            return CurrencyHelper.roundUp(futureValue(from: budget.period ?? Date()) / Double (dd))
        }
    }
    
    func recommendedDeadline(of budget: Budget) -> Date? {
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
    
    static let timeTermDictionary: [String: String] = [
        "Short"     : "< 3 tahun",
        "Medium"    : "3 tahun - 5 tahun",
        "Long"      : "> 5 tahun"
    ]
}

extension Goal {
    class Recommendation {
        var icon: String
        var name: String
        var term: String
        var description: String
        
        init(icon: String, name: String, term: String, description: String) {
            self.icon = icon
            self.name = name
            self.term = term
            self.description = description
        }
    }
    
    static let goalRecommendation: [Recommendation] = [
        Recommendation(icon: "💰", name: "Emergency Fund", term: "Short", description: "Simpanan uang yang bisa kamu pakai ketika kamu tidak punya pemasukan. "),
        Recommendation(icon: "💵", name: "Bayar Utang", term: "Medium", description: "Jangan lupa bayar utang-utangmu, nanti gawat bunganya numpuk, loh."),
        Recommendation(icon: "⛑", name: "Asuransi", term: "Medium", description: "Cicil asuransi untuk jaga-jaga hal yang gak terduga."),
        Recommendation(icon: "🧓", name: "Dana Pensiun", term: "Long", description: "Yuk, siapkan dana pensiunmu. Atau malah retiring early? Leggoooo!")
    ]
}
