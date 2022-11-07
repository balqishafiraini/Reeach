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
    
    func getUnallocatedGoals(on month: Date) -> [Goal] {
        var goals = getGoals()
        goals.removeAll { $0.isActive(on: month) }
        return goals
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
    
    func getGoalRecommendations() -> [[Goal.Recommendation]] {
        var recommendations = Goal.goalRecommendation
        let goals = getGoals()
        recommendations.removeAll {
            recommendation in
            goals.contains { $0.name == recommendation.name }
        }
        
        var result: [[Goal.Recommendation]] = [[], [], []]
        for recommendation in recommendations {
            var index = 0
            if recommendation.term == "Medium" { index = 1 }
            else if recommendation.term == "Long" { index = 2 }
            result[index].append(recommendation)
        }
        return result
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
