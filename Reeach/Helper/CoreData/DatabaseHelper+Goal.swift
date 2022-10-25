//
//  DatabaseHelper+Goal.swift
//  Reeach
//
//  Created by William Chrisandy on 13/10/22.
//

import CoreData

extension DatabaseHelper {
    func getGoals() -> [Goal] {
        do {
            let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest()
            return try context.fetch(fetchRequest)
        }
        catch let error {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
            return []
        }
    }
    
    func getGoal(name: String) -> Goal? {
        do {
            let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest(name: name)
            let result = try context.fetch(fetchRequest)
            return result.isEmpty == true ? nil : result[0]
        }
        catch let error {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
            return nil
        }
    }
    
    func getGoals(timeTerm: String) -> [Goal] {
        do {
            let fetchRequest: NSFetchRequest<Goal> = Goal.fetchRequest(timeTerm: timeTerm)
            return try context.fetch(fetchRequest)
        }
        catch let error {
            let nsError = error as NSError
            print("Unresolved error \(nsError), \(nsError.userInfo), \(nsError.localizedDescription)")
            return []
        }
    }
    
    func createGoals(name: String, icon: String, dueDate: Date, targetAmount: Double, timeTerm: String) -> Goal {
        if let goal = getGoal(name: name) {
            return goal
        }
        else {
            let goal = Goal(context: context)
            goal.name = name
            goal.type = "Goal"
            goal.icon = icon
            goal.dueDate = dueDate
            goal.targetAmount = targetAmount
            goal.timeTerm = timeTerm
            goal.createdAt = Date()
            goal.updatedAt = goal.createdAt
            return insert(goal)
        }
    }
}
