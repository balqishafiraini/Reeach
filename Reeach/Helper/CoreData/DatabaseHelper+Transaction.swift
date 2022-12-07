//
//  DatabaseHelper+Transaction.swift
//  Reeach
//
//  Created by William Chrisandy on 13/10/22.
//

import CoreData

extension DatabaseHelper {
    func getTransactions() -> [Transaction] {
        do {
            let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest()
            return try context.fetch(fetchRequest)
        }
        catch let error {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
            return []
        }
    }

    func getTransaction(id: Int) -> Transaction? {
        do {
            let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest(id: id)
            let result = try context.fetch(fetchRequest)
            return result.isEmpty == true ? nil : result[0]
        }
        catch let error {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
            return nil
        }
    }
    
    func getTransactions(on month: Date) -> [Transaction] {
        let startDate = DateFormatHelper.getStartDateOfMonth(of: month)
        let endDate = DateFormatHelper.getStartDateOfNextMonth(of: month)
        do {
            let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest(since: startDate, upTo: endDate)
            return try context.fetch(fetchRequest)
        }
        catch let error {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
            return []
        }
    }
    
    func getTransactions(of budget: Budget) -> [Transaction] {
        do {
            let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest(on: budget.period ?? Date(), of: budget.category?.name ?? "")
            return try context.fetch(fetchRequest)
        }
        catch let error {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
            return []
        }
        
    }
    
    func getTodayTransactions() -> [Transaction] {
        let startDate = DateFormatHelper.getStartDate(of: Date())
        let endDate = DateFormatHelper.getStartDateOfNextMonth(of: startDate.addingTimeInterval(86400))
        do {
            let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest(since: startDate, upTo: endDate)
            fetchRequest.fetchLimit = 2
            return try context.fetch(fetchRequest)
        }
        catch let error {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
            return []
        }
    }
    
    func getTransactions(since: Date = Date(timeIntervalSince1970: 0), upTo: Date = Date(), type: String? = nil, category: Category? = nil) -> [Transaction] {
        let startDate = DateFormatHelper.getStartDateOfMonth(of: since)
        let endDate = DateFormatHelper.getStartDateOfNextMonth(of: upTo)
        
        var result: [Transaction] = []
        
        do {
            let fetchRequest: NSFetchRequest<Transaction> = Transaction.fetchRequest(since: startDate, upTo: endDate)
            result = try context.fetch(fetchRequest)
        }
        catch let error {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
            return []
        }
        
        if let category {
            return result.filter { $0.budget?.category == category }
        }
        else if let type {
            if type == "Expense" {
                return result.filter { $0.budget?.category?.type == "Need" || $0.budget?.category?.type == "Want" }
            }
            else {
                return result.filter { $0.budget?.category?.type == type }
            }
        }
        return result
    }
    
    func createTransaction(name: String, date: Date, budget: Budget, amount: Double, notes: String) -> Transaction {
        let transaction = Transaction(context: context)
        transaction.name = name
        transaction.date = date
        transaction.budget = budget
        transaction.amount = amount
        transaction.notes = notes
        
        return insert(transaction)
    }
}
