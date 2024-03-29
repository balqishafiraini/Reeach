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
    func isAchievable(of budget: Budget, from date: Date) -> Bool {
        guard budget.category == self
        else { return false }
        
        return futureValue(from: date) <= expectedSaving(of: budget) ?? 0
    }
    
    func initialSaving(before date: Date) -> Double {
        var result = 0.0
        let budgets = budgets?.allObjects as! [Budget]
        
        for budget in budgets {
            let budgetMonth = budget.period ?? Date()
            if budgetMonth <= date {
                let transactions = budget.transactions?.allObjects as! [Transaction]
                
                for transaction in transactions {
                    result += transaction.amount
                }
            }
        }
        return result
    }
    
    func valueAfterInflation(from date: Date) -> Double {
        let month = DateFormatHelper.getStartDateOfMonth(of: date)
        let inflationRate = UserDefaults.standard.double(forKey: UserDefaultEnum().inflationRate)/1200
        let dd = DateFormatHelper.getMonthDifferences(between: month, and: dueDate ?? Date()) + 1
        
        return (targetAmount * pow((1+inflationRate), Double(dd))).rounded(.up)
    }
    
    func futureValue(from date: Date) -> Double {
        return valueAfterInflation(from: date) - initialSaving(before: date)
    }
    
    func expectedSaving(of budget: Budget) -> Double? {
        guard budget.category == self
        else { return nil }
        
        let dd = DateFormatHelper.getMonthDifferences(between: budget.period ?? Date(), and: dueDate ?? Date()) + 1
        return (budget.monthlyAllocation * Double(dd)).rounded(.up)
    }
    
    func targetAmount(of budget: Budget, from date: Date) -> Double? {
        guard budget.category == self
        else { return nil }
        
        if isAchievable(of: budget, from: date) {
            return targetAmount
        }
        else {
            let inflationRate = UserDefaults.standard.double(forKey: UserDefaultEnum().inflationRate)/1200
            
            let month = budget.period ?? Date()
            let dd = DateFormatHelper.getMonthDifferences(between: month, and: dueDate ?? Date()) + 1
            
            return ((expectedSaving(of: budget) ?? 0 + initialSaving(before: date)) * pow((1+inflationRate), Double(-dd))).rounded(.up)
        }
    }
    
    func remaining(of budget: Budget, from date: Date) -> Double? {
        guard budget.category == self
        else { return nil }
        
        return futureValue(from: date) - (expectedSaving(of: budget) ?? 0)
    }
    
    func add(of budget: Budget, from date: Date) -> Double? {
        guard budget.category == self
        else { return nil }
        
        if isAchievable(of: budget, from: date) {
            return 0
        }
        else {
            let dd = DateFormatHelper.getMonthDifferences(between: budget.period ?? Date(), and: dueDate ?? Date()) + 1
            
            return ((remaining(of: budget, from: date) ?? 0) / Double (dd)).rounded(.up)
        }
    }
    
    func recommendedMonthlyAllocation(of budget: Budget, from date: Date) -> Double? {
        if isAchievable(of: budget, from: date) {
            return budget.monthlyAllocation
        }
        else {
            let dd = DateFormatHelper.getMonthDifferences(between: budget.period ?? Date(), and: dueDate ?? Date()) + 1
            return (futureValue(from: date) / Double (dd)).rounded(.up)
        }
    }
    
    func recommendedDeadline(of budget: Budget, from date: Date) -> Date? {
        let expectedAllocation = budget.monthlyAllocation
        let month = budget.period ?? Date()
        
        let initialSaving = initialSaving(before: date)
        let inflationRate = UserDefaults.standard.double(forKey: UserDefaultEnum().inflationRate)/1200
        
        for ad in 0...1200 {
            let saving = expectedAllocation * Double(ad+1) + initialSaving
            let increasedValue = targetAmount * pow((1+inflationRate), Double(ad+1))
            
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
    
    static func categorizeGoals(goals: [Goal]) -> [[Goal]] {
        var result: [[Goal]] = []
        var shortGoals: [Goal] = []
        var mediumGoals: [Goal] = []
        var longGoals: [Goal] = []
        
        for goal in goals {
            if goal.timeTerm == "Short" {
                shortGoals.append(goal)
            }
            else if goal.timeTerm == "Medium" {
                mediumGoals.append(goal)
            }
            else if goal.timeTerm == "Long" {
                longGoals.append(goal)
            }
        }
        
        if shortGoals.isEmpty == false { result.append(shortGoals) }
        if mediumGoals.isEmpty == false { result.append(mediumGoals) }
        if longGoals.isEmpty == false { result.append(longGoals) }
        
        return result
    }
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
        Recommendation(icon: "💰", name: "Dana Darurat", term: "Short", description: "Simpanan uang yang bisa kamu pakai ketika kamu tidak punya pemasukan."),
        Recommendation(icon: "💵", name: "Tabungan bisnis baru", term: "Medium", description: "Punya bisnis sampingan bisa bantu kamu tambah penghasilan."),
        Recommendation(icon: "⛑", name: "Asuransi", term: "Medium", description: "Cicil asuransi untuk jaga-jaga hal yang gak terduga."),
        Recommendation(icon: "🧓", name: "Dana Pensiun", term: "Long", description: "Yuk, siapkan dana pensiunmu. Atau malah retiring early? Leggoooo!")
    ]
    
    static func categorizeRecommendations(_ recommendations: [Goal.Recommendation]) -> [[Goal.Recommendation]] {
        var result: [[Goal.Recommendation]] = []
        var shortRecommendations: [Goal.Recommendation] = []
        var mediumRecommendations: [Goal.Recommendation] = []
        var longRecommendations: [Goal.Recommendation] = []
        
        for recommendation in recommendations {
            if recommendation.term == "Short" {
                shortRecommendations.append(recommendation)
            }
            else if recommendation.term == "Medium" {
                mediumRecommendations.append(recommendation)
            }
            else if recommendation.term == "Long" {
                longRecommendations.append(recommendation)
            }
        }
        
        if shortRecommendations.isEmpty == false { result.append(shortRecommendations) }
        if mediumRecommendations.isEmpty == false { result.append(mediumRecommendations) }
        if longRecommendations.isEmpty == false { result.append(longRecommendations) }
        
        return result
    }
}
